import 'package:city_clinic_doctor/chat_section/select_dialog_screen.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'chatPageItems/ChatPageItems.dart';

class ChatPage extends StatefulWidget {
  static const String routeName = '/myChat';
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    super.initState();
    getDataForChat();
  }
  getDataForChat()async{
    print('======00000000000000000');
    CubeUser cuubeUser;
    String cb_id = await PreferenceHelper.getString('cb_id');
    String cb_login = await PreferenceHelper.getString('cb_login');
    String cb_pass = await PreferenceHelper.getString('cb_pass');
    String cb_name = await PreferenceHelper.getString('cb_name');
    print('pppppppppppppppp $cb_login');
    print("saved user  $cuubeUser");
    // print(cubeUser1);
    if (!cb_login.isEmpty) {
      setState(() {
        cuubeUser = CubeUser(
            login: cb_login,
            password: cb_pass,
            fullName: cb_name,
            id: int.parse(cb_id));
      });

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            settings: RouteSettings(name: "/SelectDialogScreen"),
            builder: (context) =>
                SelectDialogScreen(),
          ));
    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:Center(child: CircularProgressIndicator(),)
        // ListView.builder(
        //     scrollDirection: Axis.vertical,
        //     primary: true,
        //     itemCount: 5,
        //     itemBuilder: (BuildContext context, int index) {
        //       return ChatPageItems();
        //     }),
      ),
    );
  }
}