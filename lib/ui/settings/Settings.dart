import 'package:city_clinic_doctor/helper/DialogHelper.dart';
import 'package:city_clinic_doctor/main.dart';
import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/dialogs/LogoutDialog.dart';
import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionPage.dart';
import 'package:city_clinic_doctor/ui/settings/ChangePasswordPage.dart';
import 'package:city_clinic_doctor/ui/settings/FaqsPage.dart';
import 'package:city_clinic_doctor/ui/settings/PrivacyPolicy.dart';
import 'package:city_clinic_doctor/ui/settings/TermConditionPage.dart';
import 'package:city_clinic_doctor/ui/settings/bloc/LogoutBloc.dart';
import 'package:city_clinic_doctor/ui/settings/myAppointments/MyAppointmentsPage.dart';
import 'package:city_clinic_doctor/ui/settings/myConsults/MyConsultsPage.dart';
import 'package:city_clinic_doctor/ui/splash/Splash2.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/SvgImages.dart';
import '../../utils/SvgImages.dart';
import 'ContactUsPage.dart';

var globalContext;
class Settings extends StatefulWidget {
  static const String routeName = '/settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  User _user;
  LogoutBloc _logoutBloc = LogoutBloc();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _user = AppUtils.currentUser;
    _logoutBloc.logoutStream.listen((event) {
      if (event.success == true) {
        // CCDoctorPrefs.deleteUser(userKeys);
        PreferenceHelper.logout();
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
            Splash2()), (Route<dynamic> route) => false);
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
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _logoutBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(14),
          ),
        ),
        title: Text("Settings"),
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
//            SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SvgPicture.asset(profile_placeholder, height:64, width:64,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_user.name,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600
                        ),),
                      SizedBox(height: 2,),
                      Text("+91 ${_user.phone_number}",
                        style: TextStyle(
                            fontSize: 14.0,
                            fontFamily: 'Poppins',
                            color: kAuthTextGreyColor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline
                        ),),
                      SizedBox(height: 2,),
                      Text("View Profile",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: kPrimaryColor,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline
                        ),),
                    ],
                  ),
                  Expanded(
                    child: SvgPicture.asset(edit_profile, height:24, width:24,
                      alignment: Alignment.topRight,),
                  ),
                  SizedBox(width: 6,)
                ],
              ),
              SizedBox(height: 10,),
              Divider(
                color: kAuthTextGreyColor,
                thickness: 0.7,
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text("My Account",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline
                  ),),
              ),
              SizedBox(height: 5,),
              Container(
                height: 140,
                child:  ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      leading: SvgPicture.asset(myConsultant, height:20, width:20,),
                      title: Text('My Consults',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor
                        ),),
                      trailing: SvgPicture.asset(circleArrow, height:18, width:18,),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyConsultsPage()));
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      leading: SvgPicture.asset(myAppointment, height:20, width:20,),
                      title: Text('My Appointments',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor
                        ),),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => MyAppointmentsPage()));
                      },
                      trailing: SvgPicture.asset(circleArrow, height:18, width:18,),
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      leading: SvgPicture.asset(myPrescription, height:20, width:20,),
                      trailing: SvgPicture.asset(circleArrow, height:18, width:18,),
                      title: Text('My Prescription',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: kPrimaryColor
                        ),),
                      onTap: (){
                        successDialog(context: context,svgName: successSignUp);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (_) => PrescriptionPage()));
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: kAuthTextGreyColor,
                thickness: 0.7,
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.only(left: 12),
                child: Text("App Settings",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14.0,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline
                  ),),
              ),
              SizedBox(height: 5,),
              Container(
                height: 220,
                child:  ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Text('Terms & Conditions'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TermConditionPage()));
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      title: Text('FAQ’s'),
                      trailing: Icon(Icons.chevron_right),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FaqsPage()));
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      trailing: Icon(Icons.chevron_right),
                      title: Text('Privacy Policy'),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PrivacyPolicy()));
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      trailing: Icon(Icons.chevron_right),
                      title: Text('Contact Us'),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ContactUsPage()));
                      },
                    ),
                    ListTile(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      trailing: Icon(Icons.chevron_right),
                      title: Text('Change Password'),
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChangePasswordPage()));
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)
                ),
                color: Colors.red,
                onPressed: () {
                  getLogoutValue();
                },
                minWidth: double.infinity,
                height: 45,
                child: Text(
                  "Logout".toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
              SizedBox(
                height: 14,
              ),
            ],
          ),
        ),
      )
    );
  }

  Future<Null> getLogoutValue() async {
    String returnVal = await showDialog(context: context, builder: (_) {
      return LogoutDialog();
    });

    if (returnVal == 'logout') {
      _logoutBloc.logoutUser(_user.accessToken,  _user.user_id);
    }
  }
}