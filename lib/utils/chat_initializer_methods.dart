import 'package:city_clinic_doctor/chat_section/select_dialog_screen.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<CubeUser> getDataForChat(BuildContext context)async{
  print('======00000000000000000');
  CubeUser cuubeUser;

  String cb_id = await PreferenceHelper.getString('cb_id');
  String cb_login =
  await PreferenceHelper.getString('cb_login');
  String cb_pass = await PreferenceHelper.getString('cb_pass');
  String cb_name = await PreferenceHelper.getString('cb_name');
  print('pppppppppppppppp $cb_login');
  print("saved user  $cuubeUser");
  // print(cubeUser1);
  if (!cb_login.isEmpty) {
      cuubeUser = CubeUser(
          login: cb_login,
          password: cb_pass,
          fullName: cb_name,
          id: int.parse(cb_id));

    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       settings: RouteSettings(name: "/SelectDialogScreen"),
    //       builder: (context) =>
    //           SelectDialogScreen(cuubeUser, false, "", ""),
    //     ));
    return cuubeUser;
  } else {
    // Fluttertoast.showToast(msg: 'Please wait...');
    return null;
  }
}
