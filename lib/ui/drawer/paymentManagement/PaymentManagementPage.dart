import 'package:city_clinic_doctor/ui/settings/NotificationItems.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentManagementPage extends StatefulWidget {
  static const String routeName = '/paymentManagement';
  @override
  _PaymentManagementPageState createState() => _PaymentManagementPageState();
}

class _PaymentManagementPageState extends State<PaymentManagementPage> {

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
          title: Text("Payment Management"),
          //Ternery operator use for condition check
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
          centerTitle: false,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SizedBox(height: 10,),
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
                              controller: fromDateTextEditField,
                                enabled: false,
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
              Divider(thickness: 2, color: kPrimaryColor,),
              SizedBox(height: 25,),
              Center(
                child: Column(
                  children: [
                    Text("Total Payment Recieved",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),),
                    SizedBox(height: 8,),
                    Text(r"$129.6",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Color(0xFFCE0303),
                          fontWeight: FontWeight.w700,
                          fontSize: 20
                      ),),
                  ],
                ),
              ),
              SizedBox(height: 12,),
             Table(
               defaultVerticalAlignment: TableCellVerticalAlignment.middle,
               border: TableBorder.all(color: Colors.black26),
               children: [
                 TableRow(
                     children: [
                       TableCell(child: Text("Patient Name",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10, color: Colors.black87),)),
                       TableCell(child: Text("Amount",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10, color: Colors.black87),)),
                       TableCell(child: Text("Consultation Type",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10, color: Colors.black87),)),
                       TableCell(child: Text("Consultation ID",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10, color: Colors.black87),)),
                       TableCell(child: Text("Date",
                         textAlign: TextAlign.center,
                         style: TextStyle(fontSize: 10, color: Colors.black87),))
                     ]
                 )
               ],
             ),
              createTable()
            ],
          ),
        ),
      )
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

  Widget createTable() {
    List<TableRow> rows = [];
    for (int i = 0; i < 12; ++i) {
      rows.add(TableRow(children: [
        Padding(padding: EdgeInsets.all(6),
        child: Text("John Doe",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600
          ),),),
        Padding(padding: EdgeInsets.all(6),
        child: Text(r"$ 65",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600
          ),),),
        Padding(padding: EdgeInsets.all(6),
          child: Text("Video",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),),),
        Padding(padding: EdgeInsets.all(6),
          child: Text("CCD36589",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),),),
        Padding(padding: EdgeInsets.all(6),
          child: Text("July 06,2020",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600
            ),),)
      ]));
    }
    return Table(
        border: TableBorder.all(color: Colors.black26),
        children: rows);
  }

}


/*ListView.builder(
          scrollDirection: Axis.vertical,
          primary: true,
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return NotificationItems();
          }),*/
