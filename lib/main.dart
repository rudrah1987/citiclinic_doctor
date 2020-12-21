import 'dart:async';
import 'dart:io';

import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/home/Dashboard.dart';
import 'package:city_clinic_doctor/ui/splash/Splash2.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'modal/auth/user.dart';

void main() /*async*/{
  // await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: kPrimaryColor, // navigation bar color
    statusBarColor: kPrimaryColor, // status bar color
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SharedPreferences.setMockInitialValues({});
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(MaterialApp(
      theme: ThemeData(primaryColor: kPrimaryColor, accentColor: kAccentColor),
      debugShowCheckedModeBanner: false,
      home: SplashMain()
  ));
}

class SplashMain extends StatefulWidget{
  @override
  SplashMainState createState() => SplashMainState();
}

class SplashMainState extends State<SplashMain>{
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    getUserFromPreference();
    firebaseCloudMessagingListeners();
  }

  getUserFromPreference() {
    CCDoctorPrefs.getLoggedUser(userKeys).then((value){
      User _user = User.fromJson(value);
      print("userDataSplash -> ${_user.accessToken}");
      if(_user != null){
        Timer(Duration(seconds: 2), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Dashboard())));
      }else{
        Timer(Duration(seconds: 2), () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => Splash2())));
      }
    }).catchError((error){ print("Error -> $error");
    Timer(Duration(seconds: 2), () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Splash2())));});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child:  Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(color: kBackgroundColor),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(splash_logo, height:160, width:160,), //   <--- image
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("cityclinickwt.com".toUpperCase(), textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.2,
                                color: kSplashTextColor),
                          )

                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
    );
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print(token);
      CCDoctorPrefs.saveFBToken(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      // onBackgroundMessage: messageHandle,
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }

  /*Future<dynamic> messageHandle(Map<String, dynamic> message) async{
    if (message.containsKey("data")) {
      Map data = message['data'];
      String topic;
      if (data.containsKey("topic")) topic = data['topic'];
      if (topic == "VendorNewTrips") {
        String amount = data['amount'];
        String vehicle = data['vehicle'];
        String tripType = data['tripType'];
        String pickUpDate= data['pickUpDate'];
        String pickUpTime = data['pickUpTime'];
        String locations= data['locations'];
        FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        new FlutterLocalNotificationsPlugin();

        new AndroidInitializationSettings('app_icon');
        var bigTextStyleInformation = BigTextStyleInformation(
            'Locations: <b>${locations.replaceAll("\$", " to ")}</b><br>Vehicle: <b>$vehicle</b><br>Trip Type: <b>$tripType</b><br>Pick-Up Date: <b>$pickUpDate</b><br>Pick-Up Time: <b>$pickUpTime</b>',
            htmlFormatBigText: true,
            contentTitle: 'Amount:- <b>Rs $amount</b>',
            htmlFormatContentTitle: true,
            summaryText: 'Trip Details',
            htmlFormatSummaryText: true);
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            '1687497218170948721x8',
            'New Trips Notification ',
            'Notification Channel for vendor. All the new trips notifications will arrive here.',
            // style: AndroidNotificationStyle.BigText,
            styleInformation: bigTextStyleInformation);
        var platformChannelSpecifics =
        NotificationDetails(androidPlatformChannelSpecifics, null);

        flutterLocalNotificationsPlugin.show(5, 'Let\'s Get Wride!',
          'You Have Got A New Trip!', platformChannelSpecifics,);
      }
    }
    return null;
  }*/
}
