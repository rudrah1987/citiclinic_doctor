import 'dart:io';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apns/apns.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../main.dart';
import '../select_dialog_screen.dart';
import 'application.dart';
import 'chat_helper.dart';



final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];

    String body = data['body'];
    String message1 = data['message'];
    String isVideo = data['isVideo'];

    print("Firebase Background $isVideo");

    showNotificationWithSound(body, message1,isVideo: isVideo);
  }


  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}

Future showNotificationWithSound(body, message,{isVideo = 0}) async {
  if (flutterLocalNotificationsPlugin == null) {
    initNotification();
  }
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);

  var iOSPlatformChannelSpecifics =
  new IOSNotificationDetails(sound: "slow_spring_board.aiff");
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(
    0,
    body,
    message,
    platformChannelSpecifics,
    payload: isVideo,
  );
}

void initNotification() {
  var initializationSettingsAndroid =
  new AndroidInitializationSettings('launch_background');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);

  flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (payload) {
        print('llalit  $payload');
        return onSelectNotification(payload);
      });
}


onSelectNotification(String payload)  async {
  String cb_id = await PreferenceHelper.getString('cb_id');
  String cb_login = await PreferenceHelper.getString('cb_login');
  String cb_pass = await PreferenceHelper.getString('cb_pass');
  String cb_name = await PreferenceHelper.getString('cb_name');

  CubeUser cubeUser;
  if (cb_login != null && cb_login.isNotEmpty) {
    cubeUser = CubeUser(
        login: cb_login,
        password: cb_pass,
        fullName: cb_name,
        id: int.parse(cb_id));
  }
  if(cubeUser!=null){
    if(payload =='1'){
      ChatHelper().showIncomingCallScreen();
    }else{
      navigatorKey.currentState.push(MaterialPageRoute(builder: (_)=> SelectDialogScreen()));
    }
  }
}

deleteToken(){
  _firebaseMessaging.deleteInstanceID();
}

class FcmHelper{
  final PushConnector connector = createPushConnector();

  void initFirebase() {
    // Firebase.initializeApp();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
//        showNotificationWithSound("body", "message");
        },
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
//        showNotificationWithSound("body", "message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
//        showNotificationWithSound("body", "message");
        },
        onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler);

    //Needed by iOS only
    // _firebaseMessaging.requestNotificationPermissions(
    //     const IosNotificationSettings(sound: true, badge: true, alert: true));
    // _firebaseMessaging.onIosSettingsRegistered
    //     .listen((IosNotificationSettings settings) {
    //   print("Settings registered: $settings");
    // });

    //Getting the token from FCM
    _firebaseMessaging.getToken().then((String token) {
      PreferenceHelper.saveString('fcmToken', token);
      print("Firebase Token:  $token");
    });
  }

  void register() async {
    final connector = this.connector;
    connector.configure(
      // onLaunch: (data) => onPush('onLaunch', data),
      // onResume: (data) => onPush('onResume', data),
      // onMessage: (data) => onPush('onMessage', data),
      // onBackgroundMessage: _onBackgroundMessage,

      onLaunch: (data) {
        print("onLaunch $data");
        return;
      },
      onResume: (data) {
        print("onResume $data");
        onPush('onResume', data);
      },
      onMessage: (data) {
        print("onMessage $data");
        return;
      },
      onBackgroundMessage: _onBackgroundMessage,
    );
    connector.token.addListener(() {
      PreferenceHelper.saveString('fcmToken', connector.token.value);
      print("Firebase Token:  ${connector.token.value}");
      print('Token ${connector.token.value}');
    });
    connector.requestNotificationPermissions();

    if (connector is ApnsPushConnector) {
      connector.shouldPresent = (x) {
        Future.value(true);
      };
    }
  }


  Future<dynamic> onPush(String name, Map<String, dynamic> payload) async {
    // storage.append('$name: $payload');
    print("Push Data $payload");


    String cb_id = await PreferenceHelper.getString('cb_id');
    String cb_login = await PreferenceHelper.getString('cb_login');
    String cb_pass = await PreferenceHelper.getString('cb_pass');
    String cb_name = await PreferenceHelper.getString('cb_name');
    String isVideo = payload["isVideo"];

    CubeUser cubeUser;
    if (cb_login != null && cb_login.isNotEmpty) {
      cubeUser = CubeUser(
          login: cb_login,
          password: cb_pass,
          fullName: cb_name,
          id: int.parse(cb_id));
    }
    if(cubeUser!=null){
      if(isVideo =='1'){
        ChatHelper().showIncomingCallScreen();
      }else{
        navigatorKey.currentState.push(MaterialPageRoute(builder: (_)=> SelectDialogScreen()));
      }
    }
    return Future.value(true);
  }

  Future<dynamic> _onBackgroundMessage(Map<String, dynamic> data) {
    print("onBackgroundMessage $data");
    onPush('onBackgroundMessage', data);
  }
}