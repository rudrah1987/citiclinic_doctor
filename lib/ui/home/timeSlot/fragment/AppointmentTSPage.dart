import 'package:city_clinic_doctor/modal/auth/user.dart';
import 'package:city_clinic_doctor/modal/home/DayWiseModal.dart';
import 'package:city_clinic_doctor/modal/profile/UserDetailResponse.dart';
import 'package:city_clinic_doctor/ui/home/timeSlot/bloc/AppointmentScheduleBloc.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart' as intl;

class AppointmentTSPage extends StatefulWidget {
  @override
  _AppointmentTSPageState createState() => _AppointmentTSPageState();
}

class _AppointmentTSPageState extends State<AppointmentTSPage> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final GlobalKey<FormState> _formKey = GlobalKey();
  TimeOfDay _currentTime = new TimeOfDay.now();
  final dfTime = new intl.DateFormat('hh:mm:ss');
  String fromMorningTime,
      toMorningTime,
      fromAfternoonTime,
      toAfternoonTime,
      fromEveningTime,
      toEveningTime;
  int dayValue, sessionValue;
  UserData _user;

  List<DropdownMenuItem<DayWiseModal>> _dropDownDayWiseItem;
  DayWiseModal _selectedDayItem;
  List<DayWiseModal> _dropdownDayWiseList = [
    DayWiseModal("Monday", 1),
    DayWiseModal("Tuesday", 2),
    DayWiseModal("Wednesday", 3),
    DayWiseModal("Thursday", 4),
    DayWiseModal("Friday", 5),
    DayWiseModal("Saturday", 6),
    DayWiseModal("Sunday", 7),
  ];

  List<DropdownMenuItem<SessionWiseModal>> _dropDownSessionWiseItem;
  SessionWiseModal _selectedSessionItem;
  List<SessionWiseModal> _dropdownSessionWiseList = [
    SessionWiseModal("Morning", 1),
    SessionWiseModal("Afternoon", 2),
    SessionWiseModal("Evening", 3),
  ];

  TextEditingController fromMorningTimeTextField = TextEditingController();
  TextEditingController toMorningTimeTextField = TextEditingController();
  TextEditingController fromAfternoonTimeTextField = TextEditingController();
  TextEditingController toAfternoonTimeTextField = TextEditingController();
  TextEditingController fromEveningTimeTextField = TextEditingController();
  TextEditingController toEveningTimeTextField = TextEditingController();

  AddAppointmentBloc _addAppointmentBloc = AddAppointmentBloc();

  @override
  void initState() {
    super.initState();
    _user = AppUtils.currentUser;
    fromMorningTime = "";
    toMorningTime = "";
    fromAfternoonTime = "";
    toAfternoonTime = "";
    fromEveningTime = "";
    toEveningTime = "";
    dayValue = 0;
    sessionValue = 0;

    _selectedDayItem = null;
    _selectedSessionItem = null;
    _dropDownSessionWiseItem = buildSessionWiseList(_dropdownSessionWiseList);
    _dropDownDayWiseItem = buildDayWiseList(_dropdownDayWiseList);

    _addAppointmentBloc.addAppointmentStream.listen((event) {
      if (event.success != null) {
        if (event.success) {
          AppUtils.showError(event.message, _globalKey);
        } else {
          AppUtils.showError(event.message, _globalKey);
          print(event.message);
        }
      }
    });

    _addAppointmentBloc.errorStream.listen((event) {
      print("profileErrorStream -> $event");
      AppUtils.showError(event.toString(), _globalKey);
    });

    _addAppointmentBloc.loadingStream.listen((event) {
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
    _addAppointmentBloc?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Select Day",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xFFF2F2F2),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          value: _selectedDayItem,
                          items: _dropDownDayWiseItem,
                          hint: Text("Select Day"),
                          onChanged: (value) {
                            setState(() {
                              _selectedDayItem = value;
                              print(
                                  "DayValue :: ${_selectedDayItem.day} :: ${_selectedDayItem.dayValue}");
                            });
                          }),
                    ),
                  ),
                  SizedBox(height: 20),
                  /*  Padding(padding: EdgeInsets.only(left: 8),
                    child: Text("Select Session",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Poppins'
                      ),),),
                   SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(8, 2, 8, 2),
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      color: Color(0xFFF2F2F2),
                      border: Border.all(width: 1, color: Colors.grey)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        value: _selectedSessionItem,
                        items: _dropDownSessionWiseItem,
                        hint: Text("Select session"),
                        onChanged: (value) {
                          setState(() {
                            _selectedSessionItem = value;
                            print("SessionValue :: ${_selectedSessionItem.session} :: ${_selectedSessionItem.sessionValue}");
                          });
                        }),
                  ),
                ),*/
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Morning Session",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "From",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextField(
                                    enabled: false,
                                    controller: fromMorningTimeTextField,
                                    keyboardType: TextInputType.text,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectMorningFromTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "To",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextFormField(
                                    enabled: false,
                                    controller: toMorningTimeTextField,
                                    keyboardType: TextInputType.datetime,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectMorningToTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Afternoon Session",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "From time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextField(
                                    enabled: false,
                                    controller: fromAfternoonTimeTextField,
                                    keyboardType: TextInputType.text,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectAfternoonFromTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "To time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextFormField(
                                    enabled: false,
                                    controller: toAfternoonTimeTextField,
                                    keyboardType: TextInputType.datetime,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectAfternoonToTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 1.5,
                    color: Colors.grey[300],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: Text(
                      "Evening Session",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          fontFamily: 'Poppins'),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "From time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextField(
                                    enabled: false,
                                    controller: fromEveningTimeTextField,
                                    keyboardType: TextInputType.text,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectEveningFromTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              "To time",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: <Widget>[
                                TextFormField(
                                    enabled: false,
                                    controller: toEveningTimeTextField,
                                    keyboardType: TextInputType.datetime,
                                    style: Theme.of(context).textTheme.body1,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.fromLTRB(
                                                12, 6, 48, 6),
                                        border: OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(
                                            const Radius.circular(25.0),
                                          ),
                                        ),
                                        filled: true,
                                        hintStyle: new TextStyle(
                                            color: Colors.grey[800]),
                                        hintText: "Select time",
                                        fillColor: Colors.white70)),
                                IconButton(
                                  icon: Icon(Icons.timer_sharp,
                                      color: kPrimaryColor),
                                  onPressed: () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    selectEveningToTime(context);
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  FlatButton(
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                    color: kPrimaryColor,
                    onPressed: () {
                      if (_selectedDayItem == null) {
                        Fluttertoast.showToast(
                            msg: "Please select day",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } /*else if(_selectedSessionItem == null){
                        Fluttertoast.showToast(
                            msg: "Please select session",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      }*/
                      else if (fromMorningTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select morning from time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else if (toMorningTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select morning to time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else if (fromAfternoonTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select afternoon from time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else if (toAfternoonTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select afternoon to time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else if (fromEveningTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select evening from time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else if (toEveningTimeTextField.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Please select evening to time",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIos:
                                1, // also possible "TOP" and "CENTER"
                            backgroundColor: kBackgroundColor,
                            textColor: Colors.white);
                      } else {
                        _addAppointmentBloc.addAppointmentSchedule(
                            _user.accessToken,
                            _user.userId,
                            _selectedDayItem.day,
                            fromMorningTime,
                            toMorningTime,
                            fromAfternoonTime,
                            toAfternoonTime,
                            fromEveningTime,
                            toEveningTime);
                      }
                    },
                    height: 50,
                    child: Text(
                      "Add Schedule",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  List<DropdownMenuItem<SessionWiseModal>> buildSessionWiseList(
      List listItems) {
    List<DropdownMenuItem<SessionWiseModal>> items = List();
    for (SessionWiseModal listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.session),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<DayWiseModal>> buildDayWiseList(List listItems) {
    List<DropdownMenuItem<DayWiseModal>> items = List();
    for (DayWiseModal listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.day),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Future<Null> selectMorningToTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print("SelectedToTime :: $formattedTime");
          toMorningTimeTextField.text = formattedTime;
          toMorningTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }

  Future<Null> selectMorningFromTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print(
              "SelectedFromTime :: $formattedTime :: ${selectedTime.hour} : ${selectedTime.minute}");
          fromMorningTimeTextField.text = formattedTime;
          fromMorningTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }

  Future<Null> selectAfternoonToTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print("SelectedToTime :: $formattedTime");
          toAfternoonTimeTextField.text = formattedTime;
          toAfternoonTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }

  Future<Null> selectAfternoonFromTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print(
              "SelectedFromTime :: $formattedTime :: ${selectedTime.hour} : ${selectedTime.minute}");
          fromAfternoonTimeTextField.text = formattedTime;
          fromAfternoonTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }

  Future<Null> selectEveningToTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print("SelectedToTime :: $formattedTime");
          toEveningTimeTextField.text = formattedTime;
          toEveningTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }

  Future<Null> selectEveningFromTime(BuildContext context) async {
    TimeOfDay selectedTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );

    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    if (selectedTime != null) {
      String formattedTime = localizations.formatTimeOfDay(selectedTime,
          alwaysUse24HourFormat: false);
      if (formattedTime != null) {
        setState(() {
          print(
              "SelectedFromTime :: $formattedTime :: ${selectedTime.hour} : ${selectedTime.minute}");
          fromEveningTimeTextField.text = formattedTime;
          fromEveningTime = "${selectedTime.hour}:${selectedTime.minute}:00";
        });
      }
    }
  }
}
