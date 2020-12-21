import 'dart:async';

import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class VerifyOtpDialog extends StatefulWidget {
  UserSignUpData user;
  VerifyOtpDialog(this.user);

  @override
  _VerifyOtpDialogState createState() => _VerifyOtpDialogState();
}

class _VerifyOtpDialogState extends State<VerifyOtpDialog> {
  Timer _timer;
  int _start = 60;
  String smsCode = '';
  bool resendOtpVisible = false;
  TextEditingController pinFieldController;

  @override
  void initState() {
    super.initState();
    pinFieldController = TextEditingController();
    pinFieldController.addListener(() {
      final text = pinFieldController.text.toLowerCase();
      pinFieldController.value = pinFieldController.value.copyWith(
        text: text,
        selection:
        TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    pinFieldController.text = widget.user.otp;
    _getAppSignature();
    // _startListeningSms();
    startTimer();
  }

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

  _buildResetPassChild(BuildContext context) => SingleChildScrollView(
        child: Container(
          height: 350,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  title: const Text(
                    "Verify Mobile",
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  subtitle: RichText(
                    text: TextSpan(
                        style:
                            TextStyle(fontSize: 14, color: kAuthTextGreyColor),
                        text:
                            "Enter OTP sent to ${widget.user.phone_number}. Wrong Mobile number.",
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                  // Navigator.of(context, rootNavigator: true).pop();
                                },
                              text: "Click Here.",
                              style: TextStyle(
                                  color: kPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  decoration: TextDecoration.underline))
                        ]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                const Text(
                  "OTP",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 10),
                    child: PinInputTextField(
                      controller: pinFieldController,
                      decoration: BoxLooseDecoration(strokeColorBuilder: PinListenColorBuilder(Colors.cyan, Colors.green)),
                      pinLength: 4,
                      autoFocus: true,
                    )),
                SizedBox(
                  height: 40,
                ),
                FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  color: kPrimaryColor,
                  onPressed: () => {
                    smsCode = pinFieldController.text.toString(),
                    print(
                        "phone -> ${widget.user.phone_number} :: otp -> ${widget.user.otp}"),
                    if (widget.user.otp == "")
                      {
                        Fluttertoast.showToast(
                            msg: "Please enter otp",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white)
                      }
                    else if (smsCode != widget.user.otp)
                      {
                        Fluttertoast.showToast(
                            msg: "OTP is not matching",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1,
                            // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white)
                      }
                    else
                      {
                        print(
                            "phone -> ${widget.user.phone_number} :: otp -> ${widget.user.otp}"),
                        Navigator.pop(context, 'success')
                      }
                    /*, Navigator.of(context, rootNavigator: true).pop()*/
                  },
                  minWidth: 200,
                  height: 42,
                  child: Text(
                    "Verify",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Visibility(
                  visible: !resendOtpVisible,
                    child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                        style:
                            TextStyle(fontSize: 14, color: kAuthTextGreyColor),
                        text: "Resend OTP : ",
                        children: [
                          TextSpan(
                              text: "$_start Sec",
                              style: TextStyle(color: Colors.red))
                        ]),
                  ),
                )),
                Visibility(
                  visible: resendOtpVisible,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("Resend OTP",
                            style: TextStyle(fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: kPrimaryColor)
                        ),
                      ), onTap: (){
                        Navigator.pop(context, 'resend');
                      },
                    ))
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    ///stopListening
    SmsRetrieved.stopListening();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            resendOtpVisible = true;
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  /// Get signature code
  _getAppSignature() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("App Hash Key :: $signature");
  }

  ///Here ListeningSms
  _startListeningSms() async {
    String otp = await SmsRetrieved.startListeningSms();
    print("Otp value :- ${otp.replaceAll("<#>Your OTP is: ", "")}");
    if (otp.isNotEmpty || otp != null) {
      pinFieldController.text = otp.replaceAll("<#>Your OTP is: ", "").split(" ")[0];
    }
  }
}
