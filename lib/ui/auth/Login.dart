import 'dart:convert';

import 'package:city_clinic_doctor/chat_section/utils/application.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassData.dart';
import 'package:city_clinic_doctor/modal/auth/ForgotPassResponse.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/CreateNewPasswordDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/ForgotPassOtpVerifyDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/ResetPasswordDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/SuccessTaskDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ForgotPassBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ForgotPassVerifyOtpBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ForgotResendOtpBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ResetPasswordBloc.dart';
import 'package:city_clinic_doctor/ui/home/Dashboard.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'SignUp.dart';

var globalContext;
class Login extends StatefulWidget{
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login>{

  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  double locLatitude;
  double locLongitude;
  bool passwordVisible;
  UserForgotData user;
  bool isEmail = false;
  String emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  String mobilePattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';

  LoginBloc _loginBloc = LoginBloc();
  ForgotPassBloc _forgotPassBloc = ForgotPassBloc();
  ForgotResendOtpBloc _resendOtpBloc = ForgotResendOtpBloc();
  ForgotPassVerifyOtpBloc _forgotPassVerifyOtpBloc = ForgotPassVerifyOtpBloc();
  ResetPasswordBloc _resetPasswordBloc = ResetPasswordBloc();

  @override
  void initState() {
    super.initState();
    getLocationData();
    passwordVisible = false;
    user = null;

    _loginBloc.loginStream.listen((event) {
      if (event.user != null) {
        AppUtils.currentUser = event.user;
        PreferenceHelper.saveUser(event.user);
        PreferenceHelper.saveString("cUser", event.user.quickLogin,);
        PreferenceHelper.saveString("cPass", event.user.quickPassword,);
        PreferenceHelper.saveString("cid", event.user.quickId,);
        Application().initApp();
        print("userAccessTokenAtLoginInit -> ${event.user.accessToken}");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Dashboard()), (Route<dynamic> route) => false);
      } else {
        print(event.message);
        AppUtils.showError(event.message, _globalKey);
      }
    });

    _loginBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _loginBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.of(context).pop();
          // Navigator.pop(globalContext);
        }
      }
    });

    _forgotPassBloc.forgotPassStream.listen((event) {
      if (event.user != null) {
        user = event.user;
        getVerifyOtpValue(event.user);
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _forgotPassBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _forgotPassBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });

    _forgotPassVerifyOtpBloc.forgotPassVerifyOtpStream.listen((event) {
      if (event.user != null) {
        resetPasswordValue(event.user.user_id);
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _forgotPassVerifyOtpBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _forgotPassVerifyOtpBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });

    _resetPasswordBloc.resetPassStream.listen((event) {
      if (event.success == true) {
        showDialog(context: context, builder: (_)
        {
          return SuccessTaskDialog(event.message);
        });
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _resetPasswordBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _resetPasswordBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  getLocationData() async {
    locLatitude = await CCDoctorPrefs.getCurrentLocationLatitude();
    locLongitude = await CCDoctorPrefs.getCurrentLocationLongitude();

    print("Location :- Lat -> $locLatitude :: Lng -> $locLongitude");
  }

  @override
  void dispose() {
    super.dispose();
    _forgotPassBloc?.dispose();
    _loginBloc?.dispose();
    _forgotPassVerifyOtpBloc?.dispose();
    _resetPasswordBloc?.dispose();
    _phoneController?.dispose();
    _passwordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "Welcome back!",
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  subtitle: Text("Enter your details to continue.",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: kAuthTextGreyColor),),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    key: _formKey,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                        TextFormField(
                        controller: _phoneController,
                        cursorColor: kPrimaryColor,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                        // maxLength: 10,
                        decoration: const InputDecoration(
                          // hintText: '-Enter Mobile Number-',
                          counterText: "",
                          labelText: 'Email/Mobile Number',
                          // prefixIcon: Icon(Icons.phone_android),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                          onChanged: (value){
                            RegExp regExpEmail = new RegExp(emailPattern);
                            RegExp regExpMobile = new RegExp(mobilePattern);
                            if(regExpMobile.hasMatch(value)){
                              isEmail = false;
                            }else{
                              isEmail = true;
                            }
                          },
                        validator: (v){
                          RegExp regExpEmail = new RegExp(emailPattern);
                          RegExp regExpMobile = new RegExp(mobilePattern);
                          if (v.isEmpty) {
                            return 'Email/Mobile Number is required';
                          } else{
                            if (isEmail) {
                              if(!regExpEmail.hasMatch(v)){
                                return 'Please enter valid email address';
                              }else{
                                return null;
                              }
                            }else{
                              if(!regExpMobile.hasMatch(v)){
                                return 'Please enter valid mobile number';
                              }else if(v.length < 10){
                                return 'Please enter valid mobile number';
                              }else{
                                return null;
                              }
                            }
                          }
                          return null;
                        },
                      ),
                          SizedBox(height: 20,),
                  TextFormField(
                    controller: _passwordController,
                    cursorColor: kPrimaryColor,
                    obscureText: !passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400
                    ),
                    decoration: InputDecoration(
                      // hintText: '-Enter Password-',
                        labelText: 'Password',
                        // prefixIcon: Icon(Icons.mail_outline),
                        contentPadding: EdgeInsets.symmetric(vertical: 5),
                        suffixIcon: IconButton(
                            icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,),
                            onPressed: (){
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            })
                    ),
                    // validator: (v) {
                    //   if (v.isEmpty) {
                    //     return 'password is required';
                    //   }else if(v.length < 8){
                    //     return 'password should be atleast 8 characters';
                    //   }
                    //   return null;
                    // },
                  ),
                          SizedBox(height: 16,),
                  InkWell(
                    onTap: () {
                      showForgotPassDialog();
                    },
                    child: Text("Forgot Password?", textDirection: TextDirection.ltr,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: kPrimaryColor),
                    ),
                  ),
                          SizedBox(height: 40,),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            color: kPrimaryColor,
                            onPressed: () {
                              String phone = _phoneController.text.toString();
                              String password = _passwordController.text.toString();
                              if (_formKey.currentState.validate()) {
                                if(isEmail){
                                  _loginBloc.login(phone, password,
                                      locLongitude.toString(), locLatitude.toString(),
                                      DOCTOR_ROLE_TYPE);
                                }else{
                                  _loginBloc.login(phone, password,
                                      locLongitude.toString(), locLatitude.toString(),
                                      DOCTOR_ROLE_TYPE);
                                }
                              }
                            },
                            height: 50,
                            child: Text(
                              "Sign In",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                         /* Text(
                            "or Sign in with",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: kAuthTextGreyColor),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
//                                margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: BorderSide(color: Colors.grey)),
                                        padding: EdgeInsets.all(1.0),
                                        color: Colors.white,
                                        onPressed: () async {
//                                      _signInWithGoogle();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: SvgPicture.asset(googleImage, height:20, width:20,)
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: new Text(
                                                  "Google",
                                                  style: TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                )),
                                          ],
                                        )),
                                  )),
                              SizedBox(width: 12,),
                              Expanded(
                                  child: Container(
//                                margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
                                    child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(25.0),
                                            side: BorderSide(color: Colors.grey)),
                                        padding: EdgeInsets.all(1.0),
                                        color: Colors.white,
                                        onPressed: () async {
//                                      _signInWithGoogle();
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.all(10.0),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                child: SvgPicture.asset(facebookImage, height:20, width:20,)
                                            ),
                                            Container(
                                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                                child: new Text(
                                                  "Facebook",
                                                  style: TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                )),
                                          ],
                                        )),
                                  )),
                            ],
                          ),*/
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 14, color: kAuthTextGreyColor),
                        text: "Not a Member? ",
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SignUp()));
                                },
                              text: "Sign Up",
                              style: TextStyle(color: Colors.red))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> showForgotPassDialog() async {
    String returnVal = await showDialog(context: context, builder: (_){return ResetPasswordDialog();});
    //return value is null
    ForgotPassData data = ForgotPassData.fromJson(jsonDecode(returnVal));
    print('forgotData -> ${data.phone} :: ${data.fromPage} :: ${data.type}');
    if(data.fromPage == 'ForgotPassword'){
      _forgotPassBloc.forgotPass(data.phone);

    }
  }

  Future<Null> getVerifyOtpValue(UserForgotData user) async {
    String returnVal = await showDialog(context: context, builder: (_) {
      return ForgotPassOtpVerifyDialog(user);
    });

    if (returnVal == 'success') {
      _forgotPassVerifyOtpBloc.forgotPassVerifyOtp(user.phone_number, user.otp,
          user.result_forgot_log_id.toString(), user.user_id);
    } else if(returnVal == 'resend'){
      print("phone -> ${user.phone_number} :: userID -> ${user.user_id}");
      _resendOtpBloc.resendOtp(user.phone_number, user.user_id);
    }
  }

  Future<Null> resetPasswordValue(int userID) async {
    String returnVal = await showDialog(context: context, builder: (_) {
      return CreateNewPasswordDialog();
    });

    if (returnVal != null) {
      _resetPasswordBloc.resetPassword(returnVal, userID);
    }
  }
}