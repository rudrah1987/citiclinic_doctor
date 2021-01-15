import 'dart:io';

import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:connectycube_sdk/connectycube_chat.dart';
import './configs.dart' as config;
import 'chat_helper.dart';
import 'fcm_helper.dart';

class Application {
  static String cUser;
  static String cPass;
  static String fcmToken;

  static final Application _application = Application._();

  factory Application() {
    return _application;
  }

  Application._();

  initApp() {
    init(
      config.APP_ID,
      config.AUTH_KEY,
      config.AUTH_SECRET,
    );

    if (Platform.isAndroid) {
      FcmHelper()..initFirebase();
    }  else if (Platform.isIOS) {
      FcmHelper()..register();
    }


    initNotification();

    getUser().then((value) {
      if (cUser != null && cUser.isNotEmpty) {
        ChatHelper()..loginToCC(CubeUser(login: cUser, password: cPass));
      }
    });
  }

  Future getUser() async {
    cUser = await PreferenceHelper.getString("cUser");
    cPass = await PreferenceHelper.getString("cPass");
    fcmToken = await PreferenceHelper.getString("fcmToken");
  }
}
