import 'package:city_clinic_doctor/routes/Routes.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/LogoutDialog.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:flutter/material.dart';

import 'drawer_item.dart';

class DrawerPage extends StatelessWidget {
  final List<DrawerItem> mainOptions = [
    DrawerItem("Home",'Dashbord()'),
    DrawerItem("Statistics", Routes.statistics),
    DrawerItem("Fee Management", Routes.feeManagement),
    DrawerItem("Time Slot Management", Routes.timeSlotManagment),
    // DrawerItem("Prescription management", Routes.prescriptionManagementWithAppBar),
    // DrawerItem(
    //     "Consult Online",
    //     DoctorsPage(
    //       title: "Choose Doctor",
    //     )),
    // DrawerItem("Health Packages", Placeholder()),
    // DrawerItem("Health Articles", HealthArticlesPage()),
  ];
  final List<DrawerItem> accountOptions = [
    // DrawerItem("My Chats", Routes.myChat),
    // DrawerItem("My Account", MyAccount()),
    DrawerItem("Settings", Routes.settings),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16, bottom: 16, right: 16, left: 2),
      color: kPrimaryColor,
      child: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              splashColor: Colors.white.withOpacity(0.2),
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 42,
                  ),
                  Container(
                      child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            "$PROFILE_IMG_TESTING_BASE_PATH${currentUser.value.user?.profileImage}",
                            height: 56,
                            fit: BoxFit.cover,
                            width: 56,
                            errorBuilder: (_, o, s) {
                              return Container(
                                  width: 56,
                                  height: 56,
                                  color: Colors.white.withOpacity(0.5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    currentUser.value.user?.name != null
                                        ? "${currentUser.value.user?.name[0]}"
                                        : "Anonymous",
                                    style: TextStyle(
                                        fontSize: 22, color: kPrimaryColor),
                                  ));
                            },
                            loadingBuilder: (_, o, s) {
                              return Container(
                                  width: 56,
                                  height: 56,
                                  color: Colors.white.withOpacity(0.5),
                                  alignment: Alignment.center,
                                  child: Text(
                                    currentUser.value.user?.name != null
                                        ? "${currentUser.value.user?.name[0]}"
                                        : "Anonymous",
                                    style: TextStyle(
                                        fontSize: 22, color: kPrimaryColor),
                                  ));
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                '${currentUser.value.user?.name}',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              '${currentUser.value.user?.phoneNumber}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: mainOptions.map((item) {
                      return ListTile(
                        onTap: () {
                          //close the drawer
                          Navigator.pop(context);
                          if(item.page!="Home"){
                            Navigator.pushNamed(context, item.page);
                          }
                        },
                        contentPadding: EdgeInsets.zero,
                        dense: true,
                        title: Text(
                          item.title,
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        ),
                      );
                    }).toList(),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  ...accountOptions
                      .map((e) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            dense: true,
                            onTap: () {
                              //close the drawer
                              Navigator.pop(context);
                              Navigator.pushNamed(context, e.page);
                            },
                            title: Text('${e.title}',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white)),
                          ))
                      .toList(),
                  Divider(
                    color: Colors.white,
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return LogoutDialog();
                          });
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text('Logout',
                        style: TextStyle(fontSize: 17, color: Colors.white)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Send a message to Shivam Singh
