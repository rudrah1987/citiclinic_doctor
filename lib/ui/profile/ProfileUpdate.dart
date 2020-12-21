import 'dart:convert';
import 'dart:io';

import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/modal/profile/CityResponse.dart';
import 'package:city_clinic_doctor/modal/profile/CountryResponse.dart';
import 'package:city_clinic_doctor/modal/profile/DegreeListItem.dart';
import 'package:city_clinic_doctor/modal/profile/SpecialityResponse.dart';
import 'package:city_clinic_doctor/preference/CCDoctorPrefs.dart';
import 'package:city_clinic_doctor/preference/PreferenceKeys.dart';
import 'package:city_clinic_doctor/ui/dialogs/CityDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/CountryDialog.dart';
import 'package:city_clinic_doctor/ui/dialogs/StateDialog.dart';
import 'package:city_clinic_doctor/ui/profile/EducationQualificationPage.dart';
import 'package:city_clinic_doctor/ui/profile/RegistrationDetailsPage.dart';
import 'package:city_clinic_doctor/ui/profile/bloc/ProfileImageBloc.dart';
import 'package:city_clinic_doctor/ui/profile/bloc/ProfileUpdateBloc.dart';
import 'package:city_clinic_doctor/ui/profile/bloc/SpecialityBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/Constant.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart' as intl;

class ProfileUpdatPage extends StatefulWidget {
  @override
  _ProfileUpdatPageState createState() => _ProfileUpdatPageState();
}

class _ProfileUpdatPageState extends State<ProfileUpdatPage> {

  bool isProfileImageUpdate;
  File _coverImage, _profileImage;
  DateTime dobSelectedDate;
  DateTime currentDate = DateTime.now();
  var myFormat = intl.DateFormat('yyyy-MM-dd');
  final GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  String genderValue = "";
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController phoneFieldController = TextEditingController();
  TextEditingController dobTextFieldController = TextEditingController();
  TextEditingController countryFieldController = TextEditingController();
  TextEditingController stateFieldController = TextEditingController();
  TextEditingController cityFieldController = TextEditingController();
  TextEditingController accNumberFieldController = TextEditingController();
  TextEditingController ifscFieldController = TextEditingController();
  TextEditingController accNameFieldController = TextEditingController();
  TextEditingController addressFieldController = TextEditingController();
  TextEditingController localityFieldController = TextEditingController();
  TextEditingController experienceFieldController = TextEditingController();

  List<CityData> cityList;
  List<CountryData> countryList;
  List<SpecialityData> specialityList;

  SpecialityBloc _specialityBloc = SpecialityBloc();
  ProfileImageBloc _profileImageBloc = ProfileImageBloc();
  ProfileUpdateBloc _profileUpdateBloc = ProfileUpdateBloc();

  List<DegreeList> _dropdownItems = [
    DegreeList(0, "Select Degree"),
    DegreeList(1, "MBBS"),
    DegreeList(2, "BDS"),
    DegreeList(3, "BHMS"),
    DegreeList(4, "BAMS"),
    DegreeList(3, "DHMS"),
    DegreeList(4, "BUMS")
  ];

  List<DropdownMenuItem<DegreeList>> _dropdownMenuItems;
  DegreeList _selectedItem;

  List<DropdownMenuItem<SpecialityData>> _dropdownSpecialityData;
  SpecialityData _selectedSpecialityData;

  String _radioValue, _consultRadioValue; //Initial definition of radio button value
  String choice;

  void initState() {
    super.initState();

    isProfileImageUpdate = false;
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

    dobTextFieldController.text = "${myFormat.format(currentDate)}";
    getData();
    _user = AppUtils.currentUser;
    _profileImage = null;

    _specialityBloc.specialityStream.listen((event) {
      if (event.success == true) {
        specialityList = event.specialities;
        setState(() {
          _dropdownSpecialityData = buildDropDownSpecialityData(specialityList);
          _selectedSpecialityData = _dropdownSpecialityData[0].value;
        });
        print("specialityList -> ${event.specialities.length}");
      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _specialityBloc.errorStream.listen((event) {
      print("profileErrorStream -> $event");
      AppUtils.showError(event.toString(), _globalKey);
    });

    _specialityBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });

    _profileImageBloc.profileImageStream.listen((event) {
      if (event.success == true) {

      } else {
        AppUtils.showError(event.message, _globalKey);
        print(event.message);
      }
    });

    _profileImageBloc.errorStream.listen((event) {
      print("profileErrorStream -> $event");
      AppUtils.showError(event.toString(), _globalKey);
    });

    _profileImageBloc.loadingStream.listen((event) {
      if (context != null) {
        if (event) {
          AppUtils.showLoadingDialog(context);
        } else {
          Navigator.of(context, rootNavigator: true).pop();
        }
      }
    });

    setState(() {
      _radioValue = "1";
      _consultRadioValue = "video";
      nameFieldController.text = _user.name;
      phoneFieldController.text = _user.phone_number;
      emailFieldController.text = _user.email;
      countryFieldController.text = _user.country;
      stateFieldController.text = _user.state;
      cityFieldController.text = _user.city;
      genderValue = _user.gender;
    });
  }

  User _user;
  Future<String> _loadFromAsset() async {
    return await rootBundle.loadString("assets/country.json");
  }

  List<String> countryNames = List<String>();
  List<Map<String, List<String>>> stateMapData;
  List<Map<String, List<String>>> stateCityMapListData;

  List<Map<String, List<Map<String, List<String>>>>> countryMapDat
  = List<Map<String, List<Map<String, List<String>>>>>();

  Map<String, List<String>> stateCityMapData;
  Map<String, List<Map<String, List<String>>>> countryStateMapData;
  List<String> stateNames;

  Future parseJson() async {
    String jsonString = await _loadFromAsset();
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    print("countryJson -> $jsonResponse");

    stateMapData = List<Map<String, List<String>>>();
    jsonResponse.forEach((countryKey, value) {
      countryStateMapData = Map<String, List<Map<String, List<String>>>>();
      countryNames.add(countryKey);
      stateNames = List<String>();
      stateCityMapListData = List<Map<String, List<String>>>();
      Map<String, dynamic> stateResponse = value;
      stateResponse.forEach((stateKey, value) {
         stateCityMapData = Map<String, List<String>>();
        stateNames.add(stateKey);
        List<String> cityList = value != null ? List.from(value) : null;
         stateCityMapData[stateKey] = cityList;
         stateCityMapListData.add(stateCityMapData);
      });
      countryStateMapData[countryKey] = stateCityMapListData;
      countryMapDat.add(countryStateMapData);
    });
  }

  void getData() async {
    await parseJson();
    await _specialityBloc.getSpecialityData();
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      switch (value) {
        case '1':
          choice = value;
          break;
        case '0':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  void radioButtonConsultChanges(String value) {
    setState(() {
      _consultRadioValue = value;
      switch (value) {
        case 'audio':
          choice = value;
          break;
        case 'video':
          choice = value;
          break;
        default:
          choice = null;
      }
      debugPrint(choice); //Debug the choice in console
    });
  }

  List<DropdownMenuItem<DegreeList>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<DegreeList>> items = List();
    for (DegreeList listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<CityData>> buildDropDownCityData(List listItems) {
    List<DropdownMenuItem<CityData>> items = List();
    for (CityData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<CountryData>> buildDropDownCountryData(List listItems) {
    List<DropdownMenuItem<CountryData>> items = List();
    for (CountryData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<SpecialityData>> buildDropDownSpecialityData(List listItems) {
    List<DropdownMenuItem<SpecialityData>> items = List();
    for (SpecialityData listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.speciality_type),
          value: listItem,
        ),
      );
    }
    return items;
  }

  @override
  void dispose() {
    super.dispose();
    _specialityBloc?.dispose();
    _profileImageBloc?.dispose();
    _profileUpdateBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 210,
                  child: Stack(
                    children: [
                      Positioned(
                          child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2), //new Color.fromRGBO(255, 0, 0, 0.0),
                                borderRadius: new BorderRadius.all(Radius.circular(8.0))
                            ),
                            child: Stack(
                              //alignment:new Alignment(x, y)
                              children: <Widget>[
                                Positioned(
                                  child: Center(
                                    child: _coverImage != null ? FittedBox(child: Image.file(_coverImage,),
                                      fit: BoxFit.fill,)
                                        : SvgPicture.asset(doctorBannerBGImage, height:48, width:48,),
                                  ),
                                ),
                                Positioned(
                                  child: new Align(
                                      alignment: FractionalOffset.bottomCenter,
                                      child: GestureDetector(
                                        onTap: (){
                                          _showImagePicker(context);
                                          setState(() {
                                            isProfileImageUpdate = false;
                                          });
                                        },
                                        child: Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                              color: Color(0xFF777777), //new Color.fromRGBO(255, 0, 0, 0.0),
                                              borderRadius: new BorderRadius.only(
                                                  bottomLeft:Radius.circular(8.0),
                                                  bottomRight: Radius.circular(8.0))
                                          ),
                                          child:  Center(
                                            child: Icon(Icons.camera_alt_outlined, color: Colors.white,size: 18,),
                                          ),
                                        ),
                                      )
                                  ),
                                )
                              ],
                            ),
                          )),
                      Positioned(
                          child: Align(
                            alignment: FractionalOffset.bottomRight,
                            child: Container(
                              width: 120,
                              height: 120,
                              margin: EdgeInsets.only(right: 8),
                              // color: Color(0xFFF2F2F2),
                              decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2), //new Color.fromRGBO(255, 0, 0, 0.0),
                                  borderRadius: new BorderRadius.all(Radius.circular(8.0))
                              ),
                              child: Stack(
                                //alignment:new Alignment(x, y)
                                children: <Widget>[
                                  Positioned(
                                    child: Center(
                                      child: _profileImage != null
                                          ? FittedBox(child: Image.file(_profileImage,), fit: BoxFit.cover,)
                                          : SvgPicture.asset(home_account, height:48, width:48,),
                                    ),
                                  ),
                                  Positioned(
                                    child: new Align(
                                        alignment: FractionalOffset.bottomCenter,
                                        child: GestureDetector(
                                          onTap: (){
                                            _showImagePicker(context);
                                            setState(() {
                                              isProfileImageUpdate = true;
                                            });
                                          },
                                          child: Container(
                                            height: 24,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF777777), //new Color.fromRGBO(255, 0, 0, 0.0),
                                                borderRadius: new BorderRadius.only(
                                                    bottomLeft:Radius.circular(8.0),
                                                    bottomRight: Radius.circular(8.0))
                                            ),
                                            child:  Center(
                                              child: Icon(Icons.camera_alt_outlined, color: Colors.white,size: 12,),
                                            ),
                                          ),
                                        )
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                TextFormField(
                  controller: nameFieldController,
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Full Name-',
                    labelText: 'Full Name',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Full Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text("Speciality", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Color(0xFFF2F2F2),
                            border: Border.all(width: 1, color: Colors.grey)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              value: _selectedSpecialityData,
                              items: _dropdownSpecialityData,
                              onChanged: (value) {
                                setState(() {
                                  _selectedSpecialityData = value;
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),//Email Id Widget
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text("Gender", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: genderValue == "male"?kPrimaryColor:Colors.transparent,
                                      border: Border.all(
                                          width: 1, color: genderValue == "male"?Colors.transparent:kPrimaryColor),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  child: Text(
                                    "Male",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: genderValue == "male"?Colors.white:kPrimaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    genderValue = "male";
                                  });
                                },
                              )),
                          SizedBox(width: 20),
                          Expanded(
                              child: InkWell(
                                child: Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  padding: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                      color: genderValue == "female"?kPrimaryColor:Colors.transparent,
                                      border: Border.all(
                                          width: 1, color: genderValue == "female"?Colors.transparent:kPrimaryColor),
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                                  child: Text(
                                    "Female",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: genderValue == "female"?Colors.white:kPrimaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                onTap: (){
                                  setState(() {
                                    genderValue = "female";
                                  });
                                },
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text(
                          "Date of Birth",
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
                              keyboardType: TextInputType.text,
                              controller: dobTextFieldController,
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
                                  hintText: "-Select Date-",
                                  fillColor: Colors.white70)),
                          IconButton(
                            icon:
                            Icon(Icons.calendar_today, color: kPrimaryColor),
                            onPressed: () async {
                              DateTime toDate = DateTime(1900);
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());

                              toDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1960),
                                  lastDate: DateTime(2025));

                              if (toDate != null) /* && date != selectedDate*/
                                setState(() {
                                  dobSelectedDate = toDate;
                                  print('${myFormat.format(dobSelectedDate)}');
                                  dobTextFieldController.text =
                                  '${myFormat.format(dobSelectedDate)}';
                                });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  enabled: false,
                  controller: emailFieldController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Email Id-',
                    labelText: 'Email Id',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Email Id is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),//Mobile Number Widget
                TextFormField(
                  enabled: false,
                  controller: phoneFieldController,
                  keyboardType: TextInputType.phone,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Mobile Number-',
                    labelText: 'Mobile Number',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Mobile Number is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),//Years of Experience widget
                TextFormField(
                  controller: experienceFieldController,
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    // hintText: '-Enter Year of experience-',
                    labelText: 'Year of experience (in yrs)',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Year of experience is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text("Educational Qualification", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => EducationQualificationPage()));
                        },
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            TextField(
                                enabled: false,
                                keyboardType: TextInputType.text,
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
                                    hintText: "Enter Details",
                                    fillColor: Colors.white70)
                            ),
                            Padding(padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(circleArrow, height:18, width:18,),)
                            /*IconButton(
                          icon: ,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Your codes...
                          },
                        ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: Text("Registration Details", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegistrationDetailsPage()));
                        },
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            TextField(
                                enabled: false,
                                keyboardType: TextInputType.text,
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
                                    hintText: "Enter Details",
                                    fillColor: Colors.white70)
                            ),
                            Padding(padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(circleArrow, height:18, width:18,),)
                            /*IconButton(
                          icon: ,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            // Your codes...
                          },
                        ),*/
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: addressFieldController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    hintText: '-Enter Street Address-',
                    labelText: 'Hospital / Clinic Address',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Street Address is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: localityFieldController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w400
                  ),
                  decoration: const InputDecoration(
                    hintText: '-Enter Nearby Landmark-',
                    labelText: 'Lankmark',
                  ),
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Lankmark is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                  Container(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text("Country", textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 6,),
                        InkWell(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextField(
                                  enabled: false,
                                  controller: countryFieldController,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.body1,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(12, 6, 48, 6),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey[800]),
                                      hintText: "Select Country",
                                      fillColor: Colors.white70)
                              ),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_down_rounded), onPressed: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                showCountryDialog();
                              },
                              ),
                            ],
                          ),
                          onTap: (){
                            FocusScope.of(context).requestFocus(FocusNode());
                            showCountryDialog();
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text("State", textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 6,),
                        InkWell(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextField(
                                  enabled: false,
                                  controller: stateFieldController,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.body1,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(12, 6, 48, 6),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey[800]),
                                      hintText: "Select State",
                                      fillColor: Colors.white70)
                              ),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                onPressed: () {
                                  List<String> stateNames = List<String>();
                                  var countryData = countryFieldController.text.toString();
                                  if(countryData.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: "Please select country",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                        backgroundColor: kBackgroundColor,
                                        textColor: Colors.white);
                                  }else{
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    for(int i=0; i<stateCityListMapData.length; i++){
                                      stateCityListMapData[i].forEach((key, value) {
                                        stateNames.add(key);
                                      });
                                    }
                                    showStateDialog(stateNames);
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: (){
                            List<String> stateNames = List<String>();
                            var countryData = countryFieldController.text.toString();
                            if(countryData.isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select country",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else{
                              FocusScope.of(context).requestFocus(FocusNode());
                              for(int i=0; i<stateCityListMapData.length; i++){
                                stateCityListMapData[i].forEach((key, value) {
                                  stateNames.add(key);
                                });
                              }
                              showStateDialog(stateNames);
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text("City", textDirection: TextDirection.ltr,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ),
                        SizedBox(height: 6,),
                        InkWell(
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: <Widget>[
                              TextField(
                                  enabled: false,
                                  controller: cityFieldController,
                                  keyboardType: TextInputType.text,
                                  style: Theme.of(context).textTheme.body1,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.fromLTRB(12, 6, 48, 6),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(25.0),
                                        ),
                                      ),
                                      filled: true,
                                      hintStyle: new TextStyle(color: Colors.grey[800]),
                                      hintText: "Select City",
                                      fillColor: Colors.white70)
                              ),
                              IconButton(
                                icon: Icon(Icons.keyboard_arrow_down_rounded),
                                onPressed: () {
                                  var stateData = stateFieldController.text.toString();
                                  if(stateData.isEmpty){
                                    Fluttertoast.showToast(
                                        msg: "Please select state",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                        backgroundColor: kBackgroundColor,
                                        textColor: Colors.white);
                                  }else{
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    showCityDialog(cityListData);
                                  }
                                },
                              ),
                            ],
                          ),
                          onTap: (){
                            var stateData = stateFieldController.text.toString();
                            if(stateData.isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select state",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else{
                              FocusScope.of(context).requestFocus(FocusNode());
                              showCityDialog(cityListData);
                            }
                          },
                        )
                      ],
                    ),
                  ),

                SizedBox(height: 10),
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text("Available for Home Visit?", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Radio(
                            value: '1',
                            groupValue: _radioValue,
                            onChanged: radioButtonChanges,
                          ),
                          Text(
                            "Yes",
                          ),
                          SizedBox(width: 50,),
                          Radio(
                            value: '0',
                            groupValue: _radioValue,
                            onChanged: radioButtonChanges,
                          ),
                          Text(
                            "No",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 6),
                        child: Text("Select Consultation Type you provide?", textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Radio(
                            value: 'audio',
                            groupValue: _consultRadioValue,
                            onChanged: radioButtonConsultChanges,
                          ),
                          Text(
                            "Audio",
                          ),
                          SizedBox(width: 50,),
                          Radio(
                            value: 'video',
                            groupValue: _consultRadioValue,
                            onChanged: radioButtonConsultChanges,
                          ),
                          Text(
                            "Video",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 25),
                //Bank detail container....
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            // margin: EdgeInsets.only(left: 8),
                            child: Text("Bank Details", textDirection: TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: kPrimaryColor),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                                height: 1.0,
                                child: Container(
                                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                                  height: 5.0,
                                  color: kPrimaryColor,
                                ),
                              ))
                        ],
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: accNameFieldController,
                        keyboardType: TextInputType.name,
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                        decoration: const InputDecoration(
                          hintText: '-Enter Name-',
                          labelText: 'Account Holder Name',
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'Account Holder Name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        child:  Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 6),
                              child: Text("Bank Name", textDirection: TextDirection.ltr,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 6,),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Color(0xFFF2F2F2),
                                  border: Border.all(width: 1, color: Colors.grey)),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: _selectedItem,
                                    items: _dropdownMenuItems,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedItem = value;
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: accNumberFieldController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                        decoration: const InputDecoration(
                          hintText: '-Enter Account Number-',
                          labelText: 'Account Number',
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'Account Number is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: ifscFieldController,
                        keyboardType: TextInputType.text,
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w400
                        ),
                        decoration: const InputDecoration(
                          hintText: '-Enter IFSC Code-',
                          labelText: 'IFSC Code',
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'IFSC Code is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 50,),
                      FlatButton(
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)
                        ),
                        color: kPrimaryColor,
                        onPressed: () {
                          if(_formKey.currentState.validate()){
                            if(genderValue.isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select your gender",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else if(countryFieldController.text.toString().isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select country",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else if(stateFieldController.text.toString().isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select state",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else if(cityFieldController.text.toString().isEmpty){
                              Fluttertoast.showToast(
                                  msg: "Please select city",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                                  backgroundColor: kBackgroundColor,
                                  textColor: Colors.white);
                            }else{
                              _profileUpdateBloc.profileUpdate(_user.accessToken, _user.user_id,
                                  nameFieldController.text.toString(), genderValue, dobTextFieldController.text.toString(),
                                  experienceFieldController.text.toString(), _selectedSpecialityData.id, addressFieldController.text.toString(),
                                  localityFieldController.text.toString(), _radioValue, _consultRadioValue,
                                  cityFieldController.text.toString(), stateFieldController.text.toString(),
                                  countryFieldController.text.toString(),
                                  "SBI", accNameFieldController.text.toString(),
                                  accNumberFieldController.text.toString(), ifscFieldController.text.toString());
                            }
                          }

                          /*_settingModalBottomSheet(context);*/
                        },
                        height: 50,
                        child: Text(
                          "Review and Submit",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext bc) {
          return Container(
              height: 280.0,
              padding: EdgeInsets.all(12),
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(20.0),
                      topRight: const Radius.circular(10.0))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset(successSignUp, height:100, width:100,),
                  SizedBox(height: 10,),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      "Request Sent for Approval",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    subtitle: Text(
                      "Admin will verify your account details once approved from our end we will send you an email for account approval that your account is being verified.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          color: kAuthTextGreyColor),
                    ),),
                ],
              )
          );
        }
    );
  }

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      if(isProfileImageUpdate){
        _profileImage = image;
        Navigator.pop(context);
        _profileImageBloc.profileORCoverImage(_user.accessToken, _user.user_id, PROFILE_IMAGE, _profileImage);
      }else{
        _coverImage = image;
        Navigator.pop(context);
        _profileImageBloc.profileORCoverImage(_user.accessToken, _user.user_id, COVER_IMAGE, _coverImage);
      }
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      if(isProfileImageUpdate){
        _profileImage = image;
        Navigator.pop(context);
        _profileImageBloc.profileORCoverImage(_user.accessToken, _user.user_id, PROFILE_IMAGE, _profileImage);
      }else{
        _coverImage = image;
        Navigator.pop(context);
        _profileImageBloc.profileORCoverImage(_user.accessToken, _user.user_id, COVER_IMAGE, _coverImage);
      }
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
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          child: Column(
                            children: [
                              Image.asset(gallImage, width: 60, height: 60, fit: BoxFit.fill,),
                              SizedBox(height: 10,),
                              Text("Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),)
                            ],
                          ),
                        ),
                        onTap: (){
                          _imgFromGallery();
                        },
                      )
                      ),
                      Expanded(child:
                      InkWell(
                        child:  Container(
                          child: Column(
                            children: [
                              Image.asset(camImage, width: 60, height: 60, fit: BoxFit.fill,),
                              SizedBox(height: 10,),
                              Text("Camera",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16, color: Colors.black),)

                            ],
                          ),
                        ),
                        onTap: (){
                          _imgFromCamera();
                        },
                      )
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }

  List<Map<String, List<String>>> stateCityListMapData;
  Future<Null> showCountryDialog() async {
    print("countryData :: ${countryNames.length}");
    String returnVal = await showDialog(context: context, builder: (_){return CountryDialog(countryNames);});
    print("countrySelectionValue -> $returnVal :: ${stateMapData.length}");
    for(int i=0; i<countryMapDat.length; i++){
      if(countryMapDat[i].keys.contains(returnVal)){
        countryMapDat[i].forEach((key, value) {
          print("stateList -> $key :: $value");
          stateCityListMapData = List<Map<String, List<String>>>();
          stateCityListMapData = value;
        });
      }
    }
    countryFieldController.text = returnVal;
    stateFieldController.text = "";
    cityFieldController.text = "";
  }

  List<String> cityListData;
  Future<Null> showStateDialog(List<String> stateList) async {
    print("stateData :: ${stateList.length}");
    String returnVal = await showDialog(context: context, builder: (_){return StateDialog(stateList);});
    print("stateSelectionValue -> $returnVal");
    for(int i=0; i<stateCityListMapData.length; i++){
      if(stateCityListMapData[i].keys.contains(returnVal)){
        stateCityListMapData[i].forEach((key, value) {
          print("stateList -> $key :: $value");
          cityListData = List<String>();
          cityListData = value;
        });
      }
    }

    stateFieldController.text = returnVal;
    cityFieldController.text = "";
  }

  Future<Null> showCityDialog(List<String> cityList) async {
    print("cityData :: ${cityList.length}");
    String returnVal = await showDialog(context: context, builder: (_){return CityDialog(cityList);});
    print("citySelectionValue -> $returnVal");

    cityFieldController.text = returnVal;
  }
}
