import 'package:city_clinic_doctor/chat_section/utils/consts.dart';
import 'package:city_clinic_doctor/modal/notifications/notifications_response.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';
import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/ui/settings/NotificationItems.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationsResponse _notificationsResponse = NotificationsResponse();
  @override
  void initState() {
    super.initState();
    getNotifications();
  }
bool isDeleting=false;
  getNotifications() {
    ApiProvider().getNotifications().then((value) {
      setState(() {
        _notificationsResponse = value;
      });
      print('NOTIFICATIONS VALUE ${value.data}');
    });
  }

  deleteNotification(notiId) {
    setState(() {
      _notificationsResponse.data
          .removeWhere((element) => element.id == notiId);
    });
    ApiProvider().deleteNotifications(notiId).then((value) {
      if (value || _notificationsResponse?.data == null) {
        Fluttertoast.showToast(msg: 'Removed Successfully');
        print('NOTIFICATIONS VALUE DELETED $value');
      }
    });
  }

  deleteAllNotification() {
    setState(() {
      _notificationsResponse.data.clear();
      isDeleting=true;
    });
    ApiProvider().deleteAllNotifications().then((value) {
      if (value || _notificationsResponse?.data == null) {
        setState(() {
          isDeleting=false;
        });
        Fluttertoast.showToast(msg: 'Removed All Successfully');
        print('NOTIFICATIONS VALUE DELETED $value');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(14),
            ),
          ),
          title: Text("Notifications"),
          //Ternery operator use for condition check
          elevation:
              defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      // floatingActionButton: _notificationsResponse?.data != null
      //     ? _notificationsResponse.data.isNotEmpty?FloatingActionButton.extended(backgroundColor: primaryColor,onPressed: ()=>deleteAllNotification(), label:isDeleting?CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white),):Text('Delete App'),):null:null,
      body: _notificationsResponse?.data != null
          ? _notificationsResponse.data.isNotEmpty
              ? Column(
                  children: [
                    Container(alignment: Alignment.centerRight,child: FlatButton(onPressed: ()=>deleteAllNotification(), child:isDeleting?circulerLoading():Text('Delete App'))),
                    ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        primary: true,
                        itemCount: _notificationsResponse.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return NotificationItems(
                              _notificationsResponse.data[index], (id) {
                            deleteNotification(id);
                          });
                        }),
                  ],
                )
              : Center(child: Text('No Notifications'))
          : Center(
              child: circulerLoading(),
            ),
    );
  }
}
