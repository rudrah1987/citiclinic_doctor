import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:city_clinic_doctor/utils/SvgImages.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class StatisticsPage extends StatefulWidget {
  static const String routeName = '/statistics';
  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {

  DateTime currentDate = DateTime.now();
  DateTime fromSelectedDate, toSelectedDate;
  var myFormat = DateFormat('yyyy-MM-dd');
  TextEditingController fromDateTextEditField = TextEditingController();
  TextEditingController toDateTextEditField = TextEditingController();

  List<String> _dropdownItems = ["January", "February", "March", "April",
    "May", "June", "July", "August", "September", "October",
    "November", "December"
  ];

  List<DropdownMenuItem<String>> _dropdownMenuItems;
  String _selectedItem;

  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = _dropdownMenuItems[0].value;

    toDateTextEditField.text = '${myFormat.format(currentDate)}';
    fromDateTextEditField.text = '${myFormat.format(currentDate)}';
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
        title: Text("Statistics"),
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
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(right: 5),
                child:  Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    // width: double.infinity,
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xFFF2F2F2),
                        border: Border.all(width: 1, color: Colors.grey)),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          hint: Text("Monthly"),
                          value: _selectedItem,
                          items: _dropdownMenuItems,
                          onChanged: (value) {
                            setState(() {
                              _selectedItem = value;
                            });
                          }),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Row(
                children: [
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 8),
                        child: Text("From",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16
                          ),),),
                      SizedBox(height: 8,),
                      Container(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            TextField(
                                enabled: false,
                                controller: fromDateTextEditField,
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
                                    hintText: "-Select Date-",
                                    fillColor: Colors.white70)
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today, color: kPrimaryColor),
                              onPressed: () async{
                                DateTime fromDate = DateTime(1900);
                                FocusScope.of(context).requestFocus(new FocusNode());

                                fromDate = await showDatePicker(
                                    context: context,
                                    initialDate:DateTime.now(),
                                    firstDate:DateTime(2000),
                                    lastDate: DateTime(2025));

                                if (fromDate != null)/*&& date != currentDate*/
                                  setState(() {
                                    fromSelectedDate = fromDate;
                                    print('${myFormat.format(fromSelectedDate)}');
                                    fromDateTextEditField.text = '${myFormat.format(fromSelectedDate)}';
                                  });
                              },
                            ),
                          ],
                        ),
                      )

                    ],
                  )),
                  SizedBox(width: 15,),
                  Expanded(child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 8),
                        child: Text("To",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 16
                          ),),),
                      SizedBox(height: 8,),
                      Container(
                        child: Stack(
                          alignment: Alignment.centerRight,
                          children: <Widget>[
                            TextFormField(
                              // enabled: false,
                                controller: toDateTextEditField,
                                keyboardType: TextInputType.datetime,
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
                                    hintText: "-Select Date-",
                                    fillColor: Colors.white70)
                            ),
                            IconButton(
                              icon: Icon(Icons.calendar_today, color: kPrimaryColor),
                              onPressed: () async{
                                DateTime toDate = DateTime(1900);
                                FocusScope.of(context).requestFocus(new FocusNode());

                                toDate = await showDatePicker(
                                    context: context,
                                    initialDate:DateTime.now(),
                                    firstDate:DateTime(2000),
                                    lastDate: DateTime(2025));

                                if (toDate != null) /* && date != selectedDate*/
                                  setState(() {
                                    toSelectedDate = toDate;
                                    print('${myFormat.format(toSelectedDate)}');
                                    toDateTextEditField.text = '${myFormat.format(toSelectedDate)}';
                                  });
                              },
                            ),
                          ],
                        ),
                      )

                    ],
                  ))
                ],
              ),
              SizedBox(height: 25,),
              Card(
                  elevation: 2,
                  color: kHomeApointmentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 160,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(statisticsAppointment, height:45, width:45,),
                          SizedBox(height: 6,),
                          Text("Total Number of Appointments ", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),),
                          SizedBox(height: 10,),
                          CircleAvatar(
                            backgroundColor: kCircularRedColor,
                            child: Center(
                              child: Text(
                                "20",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 6),
              Card(
                  elevation: 2,
                  color: kHomeConsultantColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 160,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(statisticsCompletedAppointment, height:45, width:45,),
                          SizedBox(height: 6,),
                          Text("Total Number of Completed Appointments", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),),
                          SizedBox(height: 10,),
                          CircleAvatar(
                            backgroundColor: kCircularRedColor,
                            child: Center(
                              child: Text(
                                "20",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              SizedBox(height: 6),
              Card(
                  elevation: 2,
                  color: kHomeTimeSlotColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    height: 160,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(statisticsRevenue, height:45, width:45,),
                          SizedBox(height: 6,),
                          Text("Total Revenue", textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14
                            ),),
                          SizedBox(height: 10,),
                          CircleAvatar(
                            backgroundColor: kCircularRedColor,
                            child: Center(
                              child: Text(
                                "20",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
              /*SizedBox(height: 20,),
            FlatButton(
              minWidth: double.infinity,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              ),
              color: kPrimaryColor,
              onPressed: () {
                Fluttertoast.showToast(
                    msg: "Task is Pending",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1, // also possible "TOP" and "CENTER"
                    backgroundColor: kBackgroundColor,
                    textColor: Colors.white);
              },
              height: 50,
              child: Text(
                "Save",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),*/
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>>   buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }
}
