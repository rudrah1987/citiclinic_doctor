import 'package:city_clinic_doctor/ui/dialogs/CreateNewPasswordDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/ForgotPassOtpVerifyDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/LogoutDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/ResetPasswordDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/VerifyOtpDialog.dart';
import 'package:flutter/material.dart';

class DialogHelper{
  static exit(context) => showDialog(context: context, builder: (context) => ResetPasswordDialog());
  static exitCreateNewPassword(context) => showDialog(context: context, builder: (context) => CreateNewPasswordDialog());
}