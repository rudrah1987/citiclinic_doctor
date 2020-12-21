import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChatFeesFrag extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController chatDaysFieldController = TextEditingController();
  TextEditingController chatFeesFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.maxFinite,
      padding: EdgeInsets.all(16),
      child: Form(
          key: _formKey,
          child: Container(
            child: Stack(
              children: [
                Positioned(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    TextFormField(
                      controller: chatDaysFieldController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                      decoration: const InputDecoration(
                        // hintText: '-Enter Full Name-',
                          counterText: "",
                          labelText: 'ENTER NUMBER OF DAYS',
                          hintText: 'Numericals Only'
                      ),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'NUMBER OF DAYS is required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextFormField(
                      controller: chatFeesFieldController,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w400
                      ),
                      decoration: const InputDecoration(
                        // hintText: '-Enter Full Name-',
                          counterText: "",
                          labelText: 'ENTER FEES',
                          hintText: 'Numericals Only'
                      ),
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'FEES is required';
                        }
                        return null;
                      },
                    )
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
                        String chatDays = chatDaysFieldController.text.toString();
                        String chatFees = chatFeesFieldController.text.toString();
                          Fluttertoast.showToast(
                              msg: "Task is Pending",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                              backgroundColor: kBackgroundColor,
                              textColor: Colors.white);
                      }
                    },
                    height: 50,
                    child: Text(
                      "Save",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ))
              ],
            ),
          )),
    );
  }
}

