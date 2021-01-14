import 'dart:io';

import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/new/utils/prefrence_helper.dart';
import 'package:city_clinic_doctor/ui/auth/bloc/LoginBloc.dart';
import 'package:city_clinic_doctor/ui/dialogs/YearSelectionDialog.dart';
import 'package:city_clinic_doctor/ui/profile/bloc/DoctorRegistrationBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class RegistrationDetailsPage extends StatefulWidget {
  @override
  _RegistrationDetailsPageState createState() =>
      _RegistrationDetailsPageState();
}

class _RegistrationDetailsPageState extends State<RegistrationDetailsPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  TextEditingController _regNumberController = TextEditingController();
  TextEditingController _regCouncilController = TextEditingController();
  TextEditingController _regYearController = TextEditingController();
  TextEditingController regProofImageController = TextEditingController();
  DoctorRegistrationBloc _doctorRegistrationBloc = DoctorRegistrationBloc();

  DateTime currentDate = DateTime.now();
  DateTime qualSelectedDate;
  var myFormat = intl.DateFormat('yyyy');
  String currentYear;
  File _qualificationImage;
  List<String> yearList;

  void initState() {
    super.initState();
    currentYear = "${myFormat.format(currentDate)}";
    getYearList();
    setState(() {
      asignText();
    });
    _user = currentUser.value.user;
    // getUserFromPreference();
    regProofImageController.text = _qualificationImage != null
        ? "${_qualificationImage.path.split('/').last}"
        : "";

    _doctorRegistrationBloc.registrationStream.listen((event) {
      if (event.success == true) {
        Fluttertoast.showToast(
            msg: "Registration detail added successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1, // also possible "TOP" and "CENTER"
            backgroundColor: Colors.orange,
            textColor: Colors.white);
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        AppUtils.showError(event.message, _globalKey);
        print("Error msg : ${event.message}");
      }
    });

    _doctorRegistrationBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });

    _doctorRegistrationBloc.errorStream.listen((event) {
      print("doctorError -> $event");
    });
  }

  asignText() {
    print('Text asignment called---------');
    _regNumberController.text =
        currentUser.value.user.registrationDeatils.registrationNumber ?? '';
    _regCouncilController.text =
        currentUser.value.user.registrationDeatils.registrationCouncil ?? '';
    _regYearController.text = currentUser
            .value.user.registrationDeatils.registrationDate
            .substring(0, 10) ??
        '';
    regProofImageController.text =
        currentUser.value.user.registrationDeatils.documentFile ?? '';
  }

  UserData _user;
  getUserFromPreference() {
    PreferenceHelper.getUser().then((value) {
      setState(() {
        _user = value;
      });
      print("userDataRegistrationPage -> ${_user.accessToken}");
    }).catchError((error) => print("Error -> $error"));
  }

  void getYearList() {
    yearList = List<String>();
    for (int i = 1960; i <= int.tryParse(currentYear) ?? 0; i++) {
      yearList.add("$i");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _regNumberController?.dispose();
    _regCouncilController?.dispose();
    _regYearController?.dispose();
    regProofImageController?.dispose();
    _doctorRegistrationBloc?.dispose();
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
        title: Text(
          "Registration Details",
          style: TextStyle(fontSize: 17),
        ),
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
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(16),
              child: Column(children: [
                TextFormField(
                  controller: _regNumberController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Full Name-',
                    labelText: 'Registration Number',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Registration Number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _regCouncilController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Full Name-',
                    labelText: 'Registration Council',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Registration Council is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          "Select Year",
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          TextField(
                              enabled: false,
                              controller: _regYearController,
                              keyboardType: TextInputType.text,
                              style: Theme.of(context).textTheme.body1,
                              // obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(12, 6, 48, 6),
                                  border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(25.0),
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      new TextStyle(color: Colors.grey[800]),
                                  hintText: "Select year",
                                  fillColor: Colors.white70)),
                          IconButton(
                            icon: Icon(Icons.keyboard_arrow_down_rounded),
                            onPressed: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              showYearDialog();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text(
                        "Attach Registration Proof",
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: <Widget>[
                        TextField(
                            enabled: false,
                            controller: regProofImageController,
                            keyboardType: TextInputType.text,
                            style: Theme.of(context).textTheme.body1,
                            // obscureText: true,
                            decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.fromLTRB(12, 6, 48, 6),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(25.0),
                                  ),
                                ),
                                filled: true,
                                hintStyle:
                                    new TextStyle(color: Colors.grey[800]),
                                hintText: "File Name Here",
                                fillColor: Colors.white70)),
                        IconButton(
                          icon: SvgPicture.asset(
                            attachFileImage,
                            height: 30,
                            width: 30,
                          ),
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Your codes...
                            _showImagePicker(context);
                          },
                        ),
                      ],
                    )
                  ],
                )),
                SizedBox(height: 80),
                FlatButton(
                  minWidth: double.infinity,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0)),
                  color: kPrimaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      if (_qualificationImage != null) {
                        _doctorRegistrationBloc.doctorRegistration(
                            _user.accessToken,
                            _user.userId,
                            _regNumberController.text.toString(),
                            _regCouncilController.text.toString(),
                            _regYearController.text.toString(),
                            _qualificationImage);
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please attach registration proof file.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      }
                    }
                  },
                  height: 50,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _qualificationImage = image;
      Navigator.pop(context);
      regProofImageController.text = _qualificationImage != null
          ? "${_qualificationImage.path.split('/').last}"
          : "";
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _qualificationImage = image;
      Navigator.pop(context);
      regProofImageController.text = _qualificationImage != null
          ? "${_qualificationImage.path.split('/').last}"
          : "";
    });
  }

  void _showImagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              height: 140,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: InkWell(
                        child: Container(
                          child: Column(
                            children: [
                              Image.asset(
                                gallImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _imgFromGallery();
                        },
                      )),
                      Expanded(
                          child: InkWell(
                        child: Container(
                          child: Column(
                            children: [
                              Image.asset(
                                camImage,
                                width: 60,
                                height: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Camera",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _imgFromCamera();
                        },
                      ))
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<Null> showYearDialog() async {
    print("yearListData :: ${yearList.length}");
    String returnVal = await showDialog(
        context: context,
        builder: (_) {
          return YearSelectionDialog(yearList);
        });
    print("yearSelectionValue -> $returnVal");

    _regYearController.text = returnVal;
  }
}
