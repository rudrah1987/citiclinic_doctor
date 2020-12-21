import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AddTimeSlotPage extends StatefulWidget {
  @override
  _AddTimeSlotPageState createState() => _AddTimeSlotPageState();
}

class _AddTimeSlotPageState extends State<AddTimeSlotPage> {

  String currentDay, nextDay;

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
        title: Text("Add Appointment Slot"),
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
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                                child: Row(
                                  children: [
                                    // Radio(
                                    //   value: 'one',
                                    //   groupValue: _radioValue,
                                    //   onChanged: radioButtonChanges,
                                    // ),
                                    Text(
                                      "Doctor Visit",
                                      style: TextStyle(color: Colors.black,
                                          fontSize: 14),
                                    )
                                  ],
                                )
                            )),

                        Expanded(child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                // Radio(
                                //   value: 'two',
                                //   groupValue: _radioValue,
                                //   onChanged: radioButtonChanges,
                                // ),
                                Text(
                                  "Home Visit",
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 14),
                                )
                              ],),
                          ),
                        )),
                      ],
                    ),
                    SizedBox(height: 20,),
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
                                      // controller: fromDateTextEditField,
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
                                          // hintText: "-Select Date-",
                                          fillColor: Colors.white70)
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today, color: kPrimaryColor),
                                    onPressed: () async{
                                      DateTime date = DateTime(1900);
                                      FocusScope.of(context).requestFocus(new FocusNode());

                                      date = await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate:DateTime(1900),
                                          lastDate: DateTime(2100));

                                      if (date != null) /*&& date != selectedDate*/
                                        setState(() {
                                          // fromSelectedDate = date;
                                          // print('${myFormat.format(fromSelectedDate)}');
                                          // fromDateTextEditField.text = '${myFormat.format(fromSelectedDate)}';
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
                                    //   controller: toDateTextEditField,
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
                                          // hintText: "-Select Date-",
                                          fillColor: Colors.white70)
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.calendar_today, color: kPrimaryColor),
                                    onPressed: () async{
                                      DateTime date = DateTime(1900);
                                      FocusScope.of(context).requestFocus(new FocusNode());

                                      date = await showDatePicker(
                                          context: context,
                                          initialDate:DateTime.now(),
                                          firstDate:DateTime(1960),
                                          lastDate: DateTime(2000));

                                      if (date != null) /*&& date != selectedDate*/
                                        setState(() {
                                          // toSelectedDate = date;
                                          // print('${myFormat.format(toSelectedDate)}');
                                          // toDateTextEditField.text = '${myFormat.format(toSelectedDate)}';
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
                    SizedBox(height: 15,),
                    Divider(thickness: 2, color: kPrimaryColor,),
                    SizedBox(height: 15,),
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      border: TableBorder.all(color: Colors.black26),
                      children: [
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("MONDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("TUESDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("WEDNESDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("THURSDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("FRIDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(child: Padding(
                                padding: EdgeInsets.all(12),
                                child: Text("SATURDAY",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                              )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        ),
                        TableRow(
                            children: [
                              TableCell(
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Text("SUNDAY",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w700),),
                                  )),
                              TableCell(child: Row(
                                children: [
                                  Text("Start Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),),
                                  SizedBox(width: 30,),
                                  Text("End Time",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10, color: Colors.black87),)
                                ],
                              )),
                            ]
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
