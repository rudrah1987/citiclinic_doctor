import 'dart:collection';

import 'package:city_clinic_doctor/chat_section/select_dialog_screen.dart';
import 'package:city_clinic_doctor/main.dart';
import 'package:city_clinic_doctor/new/customs/logger_global.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/routes/Routes.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/LogoutDialog.dart';
import 'package:city_clinic_doctor/ui/drawer/drawer_page/drawer_page.dart';
import 'package:city_clinic_doctor/ui/drawer/feeManagement/FeesManagement.dart';
import 'package:city_clinic_doctor/ui/drawer/paymentManagement/PaymentManagementPage.dart';
import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionPage.dart';
import 'package:city_clinic_doctor/ui/drawer/statistics/StatisticsPage.dart';
import 'package:city_clinic_doctor/ui/home/HomePage.dart';
import 'package:city_clinic_doctor/ui/home/timeSlot/time_slot_manag/time_slot_managment.dart';
import 'package:city_clinic_doctor/ui/profile/ProfileUpdate.dart';
import 'package:city_clinic_doctor/ui/settings/NotificationPage.dart';
import 'package:city_clinic_doctor/ui/settings/Settings.dart';
import 'package:city_clinic_doctor/ui/settings/bloc/LogoutBloc.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:city_clinic_doctor/utils/DrawerWidgets.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:city_clinic_doctor/utils/chat_initializer_methods.dart';
import 'package:connectycube_sdk/connectycube_calls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Chat/ChatPage.dart';
import 'bloc/UserDetailBloc.dart';

var globalContext; // Declare global variable to store context from StatelessWidget

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CubeUser _cubeUser;
  @override
  void initState() {
    super.initState();
    getDataForChat(context).then((value) {
      if(value!=null){
        setState(() {
          _cubeUser=value;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    print('CUBEEUSER--------$_cubeUser');
    globalContext = context;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    
      title: "City Clinic",
      // initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // c
        // '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the SecondScreen widget.

        Routes.statistics: (context) => StatisticsPage(),
        Routes.feeManagement: (context) => FeesManagement(),
        Routes.prescriptionManagement: (context) => PrescriptionPage(),
        Routes.paymentManagement: (context) => PaymentManagementPage(),
        Routes.myChat: (context) => ChatPage(),
        Routes.settings: (context) => Settings(),
        Routes.timeSlotManagment:(context)=>TimeSlotManagement()
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: kPrimaryColor),
      ),
      home: DashboardPage(_cubeUser),
    );
  }
}

class DashboardPage extends StatefulWidget {
  final CubeUser cubeUser;
  DashboardPage(this.cubeUser);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey();
  ListQueue<int> _navigationQueue = ListQueue();
  LogoutBloc _logoutBloc = LogoutBloc();
  UserDetailBloc _userDetailBloc = UserDetailBloc();
  int _selectedIndex = 0;
  List<Widget> _widgetOptions;

  List<String> _bottomPagesTitle = [
    "City Clinic",
    "My Chats",
    "Prescription Management",
    "Profile Details"
  ];

  getTabs() async{
    _widgetOptions = <Widget>[
      HomePage(),
      SelectDialogScreen(),
      PrescriptionPage(),
      ProfileUpdatPage()
    ];
  }

  @override
  void initState() {
    super.initState();

    PreferenceHelper.getCUser().then((value) => print(value.login)).catchError((e)=>print(e.toString()));
    getTabs();

    PreferenceHelper.getUser().then((value) {
      setState(() {
        currentUser.value.user = value;
      });
      AppUtils.currentUser = value;
      _userDetailBloc.userDetailData(value.accessToken, value.userId);
    });
    _logoutBloc.logoutStream.listen((event) {
      if (event.success == true) {
        print("LogoutMessage -> ${event.message}");
        PreferenceHelper.logout();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SplashMain()),
            (Route<dynamic> route) => false);
        AppUtils.showError(event.message, _globalKey);
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _logoutBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _logoutBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          print("LoadingEvent -> $event :: $context");
          AppUtils.showLoadingDialog(context);
        } else {
          print("LoadingEvent -> $event :: $context");
          Navigator.of(globalContext, rootNavigator: true).pop();
          // Navigator.pop(globalContext);
        }
      }
    });

    _userDetailBloc.userDetailStream.listen((event) {
      if (event.user != null) {
        AppUtils.currentUser = event.user;
        PreferenceHelper.saveUser(event.user);
        // CCDoctorPrefs.saveUser(userKeys, jsonEncode(event.user.toJson()));
        print("userAccessToken -> ${event.user.accessToken}");
      } else {
        print(event.message);
        AppUtils.showError(event.message, _globalKey);
      }
    });

    _userDetailBloc.errorStream.listen((event) {
      AppUtils.showError(event.stackTrace.toString(), _globalKey);
    });

    _userDetailBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          AppUtils.close();
          // AppUtils.closeWithContext(_globalKey.currentContext);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _logoutBloc?.dispose();
    _userDetailBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> _widgetOptions = <Widget>[
    //   HomePage(),
    //   SelectDialogScreen(widget.cubeUser, false, "", ""),
    //   PrescriptionPage(),
    //   ProfileUpdatPage()
    // ];
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _globalKey,
          appBar: AppBar(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(14),
                ),
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _globalKey.currentState.openDrawer();
                },
              ),
              title: Text(
                _bottomPagesTitle.elementAt(_selectedIndex),
                style: TextStyle(fontSize: 18),
              ),
              //Ternery operator use for condition check
              elevation:
                  defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
              centerTitle: _selectedIndex == 0 ? true : false,
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    PreferenceHelper.getUser()
                        .then((value) => print('NITI-$value'));
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => NotificationPage()));
                  },
                )
              ]),
          drawer: Drawer(child: DrawerPage(),),
          // Drawer(
          //   child: ListView(
          //     children: [
          //       createHeader(context, currentUser.value?.user?.name??'',currentUser.value?.user?.profileImage??''),
          //       createDrawerItems(context, "Home", () {
          //         Navigator.of(context).pop();
          //         setState(() {
          //           _selectedIndex = 0;
          //         });
          //       }),
          //       createDrawerItems(context, "Statistics", () {
          //         Navigator.of(context).pop();
          //         Navigator.pushNamed(context, Routes.statistics);
          //       }),
          //       createDrawerItems(context, "Fee Management", () {
          //         Navigator.of(context).pop();
          //         // Fluttertoast.showToast(
          //         //     msg: 'Admin ',
          //         //     toastLength: Toast.LENGTH_SHORT,
          //         //     gravity: ToastGravity.CENTER,
          //         //     backgroundColor: Colors.red,
          //         //     textColor: Colors.white,
          //         //     fontSize: 16.0);
          //         Navigator.pushNamed(context, Routes.feeManagement);
          //       }),
          //       createDrawerItems(context, "Time Slot Managment", () {
          //         Navigator.of(context).pop();
          //         // Fluttertoast.showToast(
          //         //     msg: 'Admin ',
          //         //     toastLength: Toast.LENGTH_SHORT,
          //         //     gravity: ToastGravity.CENTER,
          //         //     backgroundColor: Colors.red,
          //         //     textColor: Colors.white,
          //         //     fontSize: 16.0);
          //         Navigator.pushNamed(context, Routes.timeSlotManagment);
          //       }),
          //       createDrawerItems(context, "Prescription Management", () {
          //         // Navigator.pushNamed(context, Routes.prescriptionManagement);
          //         Navigator.of(context).pop();
          //         setState(() {
          //           _selectedIndex = 2;
          //         });
          //       }),
          //       createDrawerItems(context, "Payment Management", () {
          //         Navigator.of(context).pop();
          //         Navigator.pushNamed(context, Routes.paymentManagement);
          //       }),
          //       createDrawerItems(context, "My Chat", () {
          //         // Navigator.pushNamed(context, Routes.myChat);
          //         Navigator.of(context).pop();
          //         setState(() {
          //           _selectedIndex = 1;
          //         });
          //       }),
          //       createDrawerItems(context, "Settings", () {
          //         Navigator.of(context).pop();
          //         Navigator.pushNamed(context, Routes.settings);
          //       }),
          //       createDrawerItems(context, "Logout", () {
          //         Navigator.of(context).pop();
          //         getLogoutValue();
          //       }),
          //     ],
          //   ),
          // ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 16,
            selectedItemColor: kPrimaryColor,
            unselectedItemColor: kAuthTextGreyColor,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(home_dashboard, height: 24, width: 24),
                activeIcon: SvgPicture.asset(
                  home_dashboard,
                  height: 24,
                  width: 24,
                  color: kPrimaryColor,
                ),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(home_chat, height: 24, width: 24),
                activeIcon: SvgPicture.asset(
                  home_chat,
                  height: 24,
                  width: 24,
                  color: kPrimaryColor,
                ),
                title: Text("Chat"),
              ),
              BottomNavigationBarItem(
                icon:
                    SvgPicture.asset(home_prescription, height: 24, width: 24),
                activeIcon: SvgPicture.asset(
                  home_prescription,
                  height: 24,
                  width: 24,
                  color: kPrimaryColor,
                ),
                title: Text("Prescription"),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(home_account, height: 24, width: 24),
                activeIcon: SvgPicture.asset(
                  home_account,
                  height: 24,
                  width: 24,
                  color: kPrimaryColor,
                ),
                title: Text("Profile"),
              ),
            ],
            onTap: onTabTapped,
          ),
          body: _widgetOptions.elementAt(_selectedIndex),
        ),
        onWillPop: () async {
          if (_navigationQueue.isEmpty) return true;

          setState(() {
            _selectedIndex = _navigationQueue.last;
            _navigationQueue.removeLast();
          });
          return false;
        });
  }

  Future<Null> getLogoutValue() async {
    String returnVal = await showDialog(
        context: context,
        builder: (_) {
          return LogoutDialog();
        });

    if (returnVal == 'logout') {
      gLogger.d('LOGOUT-${currentUser.value.user.accessToken}--${currentUser.value.user.userId}');
      _logoutBloc.logoutUser(
          currentUser.value.user.accessToken, currentUser.value.user.userId);
    }
  }

  //Dashboard Navigation drawer header widget here...
  Widget createHeader(BuildContext context, String doctorName,String imgUrl) {
    return Container(
      height: 120,
      child: DrawerHeader(
        decoration: BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(30)),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.network(
                  "$TESTING_BASE_URL$imgUrl",
                  errorBuilder: (_, __, ___) {
                    return CircleAvatar(

                      radius: 28.0,
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        "${doctorName[0]}",
                      ),
                    );
                  },
                  loadingBuilder: (_, __, ___) {
                    return CircleAvatar(

                      radius: 28.0,
                      backgroundColor: kPrimaryColor,
                      child: Text(
                        "${doctorName[0]}",
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24,
                ),
                Text(
                  doctorName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 4,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: InkWell(
                      child: Text(
                        "Edit Profile",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectedIndex = 3;
                        });
                      },
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  //dashboard screen onTabTapped
  void onTabTapped(int index) {
    _navigationQueue.addLast(index);
    setState(() {
      _selectedIndex = index;
    });
  }
}
