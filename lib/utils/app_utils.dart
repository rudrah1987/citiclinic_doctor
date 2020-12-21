import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'no_internet.dart';

class AppUtils {
  static User currentUser;
  static PublishSubject<bool> internetStream = PublishSubject();

  dispose() {
    internetStream?.close();
  }

  AppUtils() {
    print("caa");
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((result) {
      print(result);
      if (result == ConnectivityResult.none) {
        internetStream.sink.add(true);
      } else {
        internetStream.sink.add(false);
      }
    });
  }

  static BuildContext con;
  static void showLoadingDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          con = context;
          return Container(
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  static close(){
    Navigator.of(con).pop();
  }

  static void showError(String message, GlobalKey<ScaffoldState> key,
      [actionLabel, VoidCallback onTap]) {
    key.currentState?.showSnackBar(SnackBar(
      content: new Text(message),
      duration: new Duration(seconds: 3),
      action: actionLabel != null
          ? SnackBarAction(label: actionLabel, onPressed: onTap)
          : null,
    ));
  }

  static String namify(String text) {
    if (text != null)
      return text.substring(0, 1).toUpperCase() + text.substring(1);
  }

  static String getPostTypeByCode(int code) {
    switch (code) {
      case 0:
        return "Update";
        break;
      case 1:
        return "Article";
        break;
      case 2:
        return "Video";
        break;
      case 3:
        return "Event";
        break;
      default:
        return "All";
        break;
    }
  }

  static String showErrorPage(DioErrorType type, context) {
    switch (type) {
      case DioErrorType.DEFAULT:
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) => NoInternet("No Internet Connection")));
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        // TODO: Handle this case.
        break;
      case DioErrorType.SEND_TIMEOUT:
        // TODO: Handle this case.
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        // TODO: Handle this case.
        break;
      case DioErrorType.RESPONSE:
        // TODO: Handle this case.
        break;
      case DioErrorType.CANCEL:
        // TODO: Handle this case.
        break;
    }
  }
}
