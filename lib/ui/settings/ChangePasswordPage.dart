import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/dialogs/SuccessTaskDialog.dart';
import 'package:city_clinic_doctor/ui/settings/bloc/ChangePassBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {

  User _user;
  ChangePassBloc _changePassBloc = ChangePassBloc();
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool oldPasswordVisible, newPasswordVisible, confirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    getUserFromPreference();
    oldPasswordVisible = false;
    newPasswordVisible = false;
    confirmPasswordVisible = false;

    _changePassBloc.changePassStream.listen((event) {
      if (event.user != null) {
        showDialog(context: context, builder: (_)
        {
          return SuccessTaskDialog(event.message);
        });
      } else {
        print(event.message);
        AppUtils.showError(event.message, _globalKey);
      }
    });

    _changePassBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _changePassBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.pop(context);
        }
      }
    });
  }

  getUserFromPreference() {
    CCDoctorPrefs.getLoggedUser(userKeys).then((value){
      setState(() {
        _user = User.fromJson(value);
      });
      print("userData -> ${_user.accessToken}");
    }).catchError((error) => print("Error -> $error"));
  }

  @override
  void dispose() {
    super.dispose();
    _changePassBloc?.dispose();
    _oldPasswordController?.dispose();
    _newPasswordController?.dispose();
    _confirmPasswordController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(14),
          ),
        ),
        title: Text("Change Password"),
        //Ternery operator use for condition check
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        centerTitle: false,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
            color: Colors.white,
            height: double.maxFinite,
            padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Positioned(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _oldPasswordController,
                          cursorColor: kPrimaryColor,
                          obscureText: !oldPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            hintText: '-Enter Old Password-',
                            labelText: 'Old Password',
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              suffixIcon: IconButton(
                                  icon: Icon(oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,),
                                  onPressed: (){
                                    setState(() {
                                      oldPasswordVisible = !oldPasswordVisible;
                                    });
                                  })
                          ),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Old password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _newPasswordController,
                          cursorColor: kPrimaryColor,
                          obscureText: !newPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            hintText: '-Enter New Password-',
                            labelText: 'New Password',
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              suffixIcon: IconButton(
                                  icon: Icon(newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,),
                                  onPressed: (){
                                    setState(() {
                                      newPasswordVisible = !newPasswordVisible;
                                    });
                                  })
                          ),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'New password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                        TextFormField(
                          controller: _confirmPasswordController,
                          cursorColor: kPrimaryColor,
                          obscureText: !confirmPasswordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w400
                          ),
                          decoration: InputDecoration(
                            hintText: '-Re-enter New Password-',
                            labelText: 'Confirm Password',
                              contentPadding: EdgeInsets.symmetric(vertical: 5),
                              suffixIcon: IconButton(
                                  icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,),
                                  onPressed: (){
                                    setState(() {
                                      confirmPasswordVisible = !confirmPasswordVisible;
                                    });
                                  })
                          ),
                          validator: (v) {
                            if (v.isEmpty) {
                              return 'Confirm password is required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 12),
                      ],
                    )),
                Positioned(child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: FlatButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    color: kPrimaryColor,
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        String newPassword = _newPasswordController.text.toString();
                        String confirmPassword = _confirmPasswordController.text.toString();
                        if(newPassword == confirmPassword){
                          _changePassBloc.changePassword(_oldPasswordController.text.toString(),
                              newPassword, _user.accessToken, _user.user_id);
                        }else{
                          Fluttertoast.showToast(
                              msg: "Your password not match",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                              backgroundColor: kBackgroundColor,
                              textColor: Colors.white);
                        }
                      }

                    },
                    height: 50,
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ))
              ],
            )
        ),
      ),
    );
  }
}
