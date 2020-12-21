import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';

class LogoutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
      ),
      elevation: 12,
      backgroundColor: Colors.white,
      child: Container(
        height: 190,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            /*mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,*/
            children: [
            Text(
            "Logout",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: Colors.black,),
          ),
              SizedBox(height: 6,),
              Text("Are you sure you want to logout from this app?",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Poppins',
                    color: Colors.black),),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: kPrimaryColor)),
                        color: Colors.white,
                        height: 42,
                        textColor: kBackgroundColor,
                        padding: EdgeInsets.all(8.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "No",
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),),
                  SizedBox(width: 12),
                  Expanded(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.white)),
                        onPressed: () {
                          Navigator.pop(context, 'logout');
                        },
                        height: 42,
                        color: kBackgroundColor,
                        textColor: Colors.white,
                        child: Text("Yes",
                            style: TextStyle(fontSize: 16)),
                      ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
