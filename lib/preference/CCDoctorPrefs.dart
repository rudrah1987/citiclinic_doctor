import 'dart:convert';

import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CCDoctorPrefs{
  static saveUser(String key, String userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, userData);
  }

  static Future<Map> getLoggedUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return jsonDecode(prefs.getString(key));
  }

  static deleteUser(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  // Save & Get FCM Token from preference Manager
  static saveFBToken(String fbToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('FCMToken', fbToken);
  }

  static Future<String> getFBToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('FCMToken')) {
      return prefs.getString('FCMToken');
    }

    return null;
  }

// Save & Get User current location from preference Manager
  static saveCurrentLocationLatitude(double locLatitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('CurrentLocationLatitude', locLatitude);
  }

  static Future<double> getCurrentLocationLatitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('CurrentLocationLatitude')) {
      return prefs.getDouble('CurrentLocationLatitude');
    }

    return null;
  }

  static saveCurrentLocationLongitude(double locLongitude) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('CurrentLocationLongitude', locLongitude);
  }

  static Future<double> getCurrentLocationLongitude() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('CurrentLocationLongitude')) {
      return prefs.getDouble('CurrentLocationLongitude');
    }

    return null;
  }

}