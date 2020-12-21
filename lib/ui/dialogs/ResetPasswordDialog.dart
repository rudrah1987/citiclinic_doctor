import 'dart:convert';

import 'package:city_clinic_doctor/helper/DialogHelper.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassData.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ForgotPassBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ResetPasswordDialog extends StatelessWidget {
  TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 12,
      backgroundColor: Colors.white,
      child: _buildResetPassChild(context),
    );
  }

  _buildResetPassChild(BuildContext context) => Form(
    key: _formKey,
    child: Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: Text(
                "Reset Password",
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w700,
                    color: Colors.black),
              ),
              subtitle: Text("Enter your registered mobile number, we will send an OTP to reset you password.",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    color: kAuthTextGreyColor),),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _phoneController,
              cursorColor: kPrimaryColor,
              keyboardType: TextInputType.phone,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400
              ),
              decoration: const InputDecoration(
                labelText: 'Mobile Number',
                counterText: "",
                contentPadding: EdgeInsets.symmetric(vertical: 5),
              ),
              maxLength: 10,
              validator: (v) {
                String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                RegExp regExp = new RegExp(pattern);

                if (v.isEmpty) {
                  return 'Mobile Number is required';
                } else if (v.length < 10) {
                  return 'Mobile Number should be 10 Digits';
                }else if (!regExp.hasMatch(v)) {
                  return 'Please enter valid mobile number';
                }
                return null;
              },
            ),
            SizedBox(height: 40,),
            FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
              color: kPrimaryColor,
              onPressed: () {
                if(_formKey.currentState.validate()){
                  ForgotPassData forgotData = ForgotPassData(_phoneController.text.toString(), 'ForgotPassword', 'phone');
                  var jsonString = jsonEncode(forgotData.toJson());
                  Navigator.pop(context, jsonString);
                }
                // DialogHelper.exitFogotPasswordVerifyOTP(context);
              },
              minWidth: 200,
              height: 42,
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                    style: TextStyle(fontSize: 14, color: Colors.red),
                    text: "Sign In",
                    children: [
                      TextSpan(
                          text: " instead.",
                          style: TextStyle(color: kAuthTextGreyColor))
                    ]),
              ),
            )
          ],
        ),
      ),
    ),
  );
}