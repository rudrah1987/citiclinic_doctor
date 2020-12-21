import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InputChatWidget extends StatelessWidget {

  final TextEditingController textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              child: Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  TextField(
                      enabled: false,
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.body1,
                      obscureText: true,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(12, 6, 48, 6),
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25.0),
                            ),
                          ),
                          filled: true,
                          hintStyle: new TextStyle(color: Colors.grey[800]),
                          hintText: "Type your message...",
                          fillColor: Colors.white70)
                  ),
                  /*CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: DateTime(1969, 1, 1),
                    onDateTimeChanged: (DateTime newDateTime) {
                      // Do something
                    },
                  ),*/
                  IconButton(
                    icon: SvgPicture.asset(attachFileImage, height:30, width:30,),
                    onPressed: () {
                      // FocusScope.of(context).requestFocus(FocusNode());
                      // Your codes...
                    },
                  ),
                ],
              )),

          // Send Message Button
          FloatingActionButton(
            backgroundColor: kPrimaryColor,
            child: SvgPicture.asset(sendChatMsgImage, width: 24, height: 24,),
            onPressed: () {
              print("Cliked");
            },),
        ],
      ),
      width: double.infinity,
      height: 45.0,
    );
  }
}

/*Container(width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Color(0xFFF2F2F2)
            ),
            child: Row(
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Lankmark is required';
                    }
                    return null;
                  },
                ),
                SvgPicture.asset(attachFileChatImage, width: 24, height: 24,),
              ],
            ),
          )*/
