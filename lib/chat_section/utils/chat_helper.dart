import 'dart:io';

import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:device_id/device_id.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../main.dart';
import '../call_screen.dart';
import '../chat_list_bloc.dart';
import '../cube_bloc.dart';
import 'fcm_helper.dart';

class ChatHelper{

  static final ChatHelper _chatHelper = ChatHelper._();

  factory ChatHelper(){
    return _chatHelper;

  }

  ChatHelper._();
  P2PClient _callClient;
  P2PSession _currentCall;

   loginToCC(CubeUser user, {bool saveUser = false}) {
     createSession(user).then((cubeSession) async {
      var tempUser = user;
      user = cubeSession.user..password = tempUser.password;
      loginToCubeChat(user);
    }).catchError(_processLoginError);
  }

  loginToCubeChat(CubeUser user)  {
    print("_loginToCubeChat user $user");
     CubeChatConnection.instance.login(user).then((cubeUser) async {
       print('cubeUservvv ${cubeUser.password}');

       PreferenceHelper.saveString("cb_id", cubeUser.id.toString());
       PreferenceHelper.saveString("cb_login", cubeUser.login);
       PreferenceHelper.saveString("cb_pass", cubeUser.password);
       PreferenceHelper.saveString("cb_name", cubeUser.fullName);

       PreferenceHelper.saveCUser(cubeUser);

      ChatMessagesManager chatMessagesManager = CubeChatConnection.instance.chatMessagesManager;
      var v = chatMessagesManager.chatMessagesStream
        ..listen((event) {
          print('SSE $event');
          ChatListBloc().fetchList();
        });

      cubeBloc.updateCube(v);
      // ChatListBloc().fetchList();
      print('mmmmmm ${chatMessagesManager.chatMessagesStream}');
      print("_loginToCubeChat suucess");
      _initCustomMediaConfigs();
      initCalls();
      String fcmToken = await PreferenceHelper.getString("fcmToken");
      subscribe(fcmToken);
    }).catchError(_processLoginError);
  }

  subscribe(String token) async {
    log('[subscribe] token: $token');

    bool isProduction = bool.fromEnvironment('dart.vm.product');

    CreateSubscriptionParameters parameters = CreateSubscriptionParameters();
    parameters.environment =
    isProduction ? CubeEnvironment.PRODUCTION : CubeEnvironment.DEVELOPMENT;

    if (Platform.isAndroid) {
      parameters.channel = NotificationsChannels.GCM;
      parameters.platform = CubePlatform.ANDROID;
      parameters.bundleIdentifier = "com.city_clinic_doctor";
    } else if (Platform.isIOS) {
      parameters.channel = NotificationsChannels.APNS;
      parameters.platform = CubePlatform.IOS;
      parameters.bundleIdentifier = "com.city_clinic_doctor";
    }

    String deviceId = await DeviceId.getID;
    parameters.udid = deviceId;
    parameters.pushToken = token;

    // createSubscription(parameters.getRequestParameters())
    //     .then((cubeSubscription) {
    // })
    //     .catchError((error) {});

    createSubscription(parameters.getRequestParameters())
        .then((cubeSubscription) {
      log('[subscribe] subscription SUCCESS',);
      cubeSubscription.forEach((subscription) {
        print('Suni   ${subscription.id}');
        PreferenceHelper.saveString("subscrip_id", '${subscription.id}');
      });
    }).catchError((error) {
      log('[subscribe] subscription ERROR: $error');
    });
  }

  unsubscribe() {
    SharedPreferences.getInstance().then((pref) {
      var subscriptionId = pref.getString('subscrip_id');
      print('Suni1  $subscriptionId');
      if (subscriptionId != null) {
        deleteSubscription(int.parse(subscriptionId)).then((voidResult) {
          // FirebaseMessaging._instance.deleteToken();
          deleteToken();
        });
      }
    }).catchError((onError) {
      log('[unsubscribe] ERROR: $onError', "PushNotificationsManager.TAG");
    });
  }

  void _processLoginError(exception) {
    log("Login error $exception", "TAG");
    // showDialogError(exception, context);
  }

  void initCalls() {
    _callClient = P2PClient.instance;

    _callClient.init();

    _callClient.onReceiveNewSession = (callSession) {
      if (_currentCall != null &&
          _currentCall.sessionId != callSession.sessionId) {
        callSession.reject();
        return;
      }

      this.callSession = callSession;
      print('anil  ${callSession.channels.values}');
      showIncomingCallScreen();
    };

    _callClient.onSessionClosed = (callSession) {
      if (_currentCall != null &&
          _currentCall.sessionId == callSession.sessionId) {
        _currentCall = null;
      }
    };
  }

  P2PSession callSession;

  void showIncomingCallScreen() {
    print('111111111p2pcall111111111111');
    print(callSession.sessionId);
    print(callSession.callerId);
    print(callSession.state);

    Map<String, String> userInfo = callSession.cubeSdp.userInfo;
    var name = userInfo["name"];
    print('useInfo $userInfo');
    print('useInfo $name');

    // print('anil  ${callSession.channels.values.map((e) => )}');

    if(callSession.state == RTCSessionState.RTC_SESSION_CLOSED){
      print('RTC_SESSION_CLOSED');
    }else{
      navigatorKey.currentState.push(
        MaterialPageRoute(
          builder: (context) => IncomingCallScreen(callSession,name),
        ),
      );
    }

  }

  void _initCustomMediaConfigs() {
    RTCMediaConfig mediaConfig = RTCMediaConfig.instance;
    mediaConfig.minHeight = 720;
    mediaConfig.minWidth = 1280;
    mediaConfig.minFrameRate = 30;
  }
}