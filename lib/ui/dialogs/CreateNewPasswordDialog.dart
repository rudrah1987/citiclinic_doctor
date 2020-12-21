import 'package:city_clinic_doctor/utils/PasswordField.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateNewPasswordDialog extends StatefulWidget {
  @override
  _CreateNewPasswordDialogState createState() => _CreateNewPasswordDialogState();
}

class _CreateNewPasswordDialogState extends State<CreateNewPasswordDialog> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool newPasswordVisible, confirmPasswordVisible;

  @override
  void initState() {
    super.initState();

    newPasswordVisible = false;
    confirmPasswordVisible = false;
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

  _buildResetPassChild(BuildContext context) => Form(
    key: _formKey,
    child: SingleChildScrollView(
      child: Container(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  "Create New Password",
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
                subtitle: Text("Create new password for your account to be secure.",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: kAuthTextGreyColor),),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                cursorColor: kPrimaryColor,
                obscureText: !newPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w400
                ),
                decoration: InputDecoration(
                  // hintText: '-Enter Password-',
                  labelText: 'New Password',
                  // prefixIcon: Icon(Icons.mail_outline),
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
                    return 'password is required';
                  }else if(v.length < 8){
                    return 'password should be atleast 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10,),
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
                  // hintText: '-Enter Password-',
                  labelText: 'Confirm Password',
                  // prefixIcon: Icon(Icons.mail_outline),
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
                    return 'confirm password is required';
                  }else if(v.length < 8){
                    return 'confirm password should be atleast 8 characters';
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
                    String passValue = _passwordController.text.toString();
                    String confirmPassValue = _confirmPasswordController.text.toString();
                    if(passValue == confirmPassValue){
                      Navigator.pop(context, passValue);
                    }else{
                      Fluttertoast.showToast(
                          msg: "Password not match.",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                          backgroundColor: kBackgroundColor,
                          textColor: Colors.white);
                    }
                  }
                },
                minWidth: 200,
                height: 42,
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}