
import 'package:city_clinic_doctor/modal/auth/SignUpResponse.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/ui/auth/Login.dart';
import 'package:city_clinic_doctor/ui/dialogs/VerifyOtpDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/ResendOtpBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/bloc/VerifyOtpBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'SuccessSignUpPage.dart';
import 'bloc/SignUpBloc.dart';

class SignUp extends StatefulWidget{
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool checkedValue = false;
  bool passwordVisible;
  String fbToken;
  double locLatitude;
  double locLongitude;
  UserSignUpData user;

  final SignUpBloc _bloc = SignUpBloc();
  VerifyOtpBloc _verifyOtpBloc = VerifyOtpBloc();
  ResendOtpBloc _resendOtpBloc = ResendOtpBloc();

  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  @override
  void initState() {
    super.initState();

    user = null;
    _bloc.signUpStream.listen((event) {
      if (event.user != null) {
        user = event.user;
        getVerifyOtpValue(event.user);
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _bloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _bloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });

    _verifyOtpBloc.otpVerifyStream.listen((event) {
      if (event.user != null) {
        AppUtils.currentUser = event.user;
        PreferenceHelper.saveUser(event.user);
        // CCDoctorPrefs.saveUser(userKeys, jsonEncode(event.user.toJson()));
        print("userAccessTokenSignUp -> ${event.user.accessToken}");
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            SuccessSignUpPage()), (Route<dynamic> route) => false);
      } else {
        AppUtils.showError(event.message, _globalKey);
        print("Error msg : ${event.message}");
      }
    });

    _verifyOtpBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });

    _verifyOtpBloc.errorStream.listen((event) {
      print("Error -> ${event}");
      // AppUtils.showError(event.errorCode.toString(), _scaffoldKey);
    });

    _resendOtpBloc.resendOtpStream.listen((event) {
      if (event.otpData != null) {
        getVerifyOtpValue(user);
      } else {
        print(event.message);
        AppUtils.showError(event.message, _globalKey);
      }
    });

    _resendOtpBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _resendOtpBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });

    passwordVisible = false;
    getLocationData();
  }

  Future<Null> getVerifyOtpValue(UserSignUpData user) async {
    String returnVal = await showDialog(context: context, builder: (_){return VerifyOtpDialog(user);});

    if(returnVal == 'success'){
      _verifyOtpBloc.verifyOtp(user.phone_number, user.otp,
          user.user_log_id.toString(), user.user_id);

    }else if(returnVal == 'resend'){
      print("phone -> ${user.phone_number} :: userID -> ${user.user_id}");
      _resendOtpBloc.resendOtp(user.phone_number, user.user_id);
    }
  }

  getLocationData() async {
    fbToken = await CCDoctorPrefs.getFBToken();
    locLatitude = await CCDoctorPrefs.getCurrentLocationLatitude();
    locLongitude = await CCDoctorPrefs.getCurrentLocationLongitude();

    print("Location :- Lat -> $locLatitude :: Lng -> $locLongitude"
        " :: FCMToken -> $fbToken");
  }

  @override
  void dispose() {
    super.dispose();

    _bloc?.dispose();
    _verifyOtpBloc?.dispose();
    _resendOtpBloc?.dispose();
    _nameController?.dispose();
    _emailController?.dispose();
    _phoneController?.dispose();
    _passwordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    "Welcome!",
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
                            controller: _nameController,
                            cursorColor: kPrimaryColor,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
                            decoration: const InputDecoration(
                              // hintText: '-Enter Full Name-',
                              labelText: 'Full Name',
                              // prefixIcon: Icon(Icons.person),
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Full Name should be mandatory';
                              } else if (v.length < 4) {
                                return 'Full Name should be 4 digits';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 12,),
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
                              // hintText: '-Enter Mobile Number-',
                              counterText: "",
                              labelText: 'Mobile Number',
                              // prefixIcon: Icon(Icons.phone_android),
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            // maxLength: 10,
                            validator: (v) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                              RegExp regExp = new RegExp(pattern);

                              if (v.isEmpty) {
                                return 'Mobile Number should be mandatory';
                              }/* else if (v.length != 10) {
                                return 'Mobile Number should be 10 digits';
                              }else if (!regExp.hasMatch(v)) {
                                return 'Mobile Number should be valid';
                              }*/
                              return null;
                            },
                          ),
                          SizedBox(height: 12,),
                          TextFormField(
                            controller: _emailController,
                            cursorColor: kPrimaryColor,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w400
                            ),
                            decoration: const InputDecoration(
                              // hintText: '-Enter Email ID-',
                              labelText: 'Email ID',
                              // prefixIcon: Icon(Icons.mail_outline),
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                            ),
                            validator: (v) {

                              String pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                              RegExp regExp = new RegExp(pattern);

                              if (v.isEmpty) {
                                return 'Email should be mandatory';
                              }else if (!regExp.hasMatch(v)) {
                                return 'Email should be Valid';
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: 12,),
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
                              labelText: 'Create Password',
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
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Password should be mandatory';
                              }else if(v.length < 8){
                                return 'Password should be atleast 8 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 8,),
                          Container(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Padding(
                                  child: Checkbox(
                                    value: checkedValue,
                                    onChanged: (newValue) {
                                      setState(() {
                                        checkedValue = newValue;
                                      });
                                    },),
                                  padding: EdgeInsets.all(3),
                                ),
                                RichText(
                                  text: TextSpan(
                                    // Note: Styles for TextSpans must be explicitly defined.
                                    // Child text spans will inherit styles from parent
                                    style: new TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: 'I agree to all '),
                                      TextSpan(text: 'Terms & Conditions',
                                          style: new TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          fontSize: 14.0
                                        /*fontWeight: FontWeight.bold*/)),
                                      TextSpan(text: ' of city clinic.'),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)
                            ),
                            color: kPrimaryColor,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                              String fullName = _nameController.text.toString();
                              String email = _emailController.text.toString();
                              String phone = _phoneController.text.toString();
                              String password = _passwordController.text.toString();
                              if(checkedValue){
                                _bloc.signUp(fullName, phone, email, password, fbToken,
                                    locLongitude.toString(), locLatitude.toString());
                              }else{
                                _globalKey.currentState.showSnackBar(SnackBar(
                                    content: new Text("Please accept our Terms & Conditions"),
                                    duration: const Duration(milliseconds: 1200)));
                              }
                              }
                            },
                            height: 50,
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white,
                              fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 12, color: kAuthTextGreyColor),
                        text: "Already a Member? ",
                        children: [
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => Login()));
                                },
                              text: "Sign In",
                              style: TextStyle(color: Colors.red,
                              fontSize: 14.0))
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
}