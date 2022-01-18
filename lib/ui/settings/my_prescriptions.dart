import 'package:city_clinic_doctor/modal/prescriptions/prescriptions.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';
import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionItems.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PrescriptionPageWithAppBar extends StatefulWidget {
  static const String routeName = '/prescriptionManagementWithAppBar';
  @override
  _PrescriptionPageWithAppBarState createState() => _PrescriptionPageWithAppBarState();
}

class _PrescriptionPageWithAppBarState extends State<PrescriptionPageWithAppBar> {
  PrescriptionsResponse _prescriptionsResponse=PrescriptionsResponse();
  bool isLoading=true;

  @override
  void initState() {
    getAllPrescriptions();
    super.initState();
  }
  getAllPrescriptions(){
    ApiProvider().getAllPrescriptions().then((value) {
      if(value!=null){
        setState(() {
          _prescriptionsResponse=value;
          isLoading=false;
          print(_prescriptionsResponse.data.prescriptionList);
        });
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
        title: Text("My Prescription"),
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
      body: !isLoading?_prescriptionsResponse.data.prescriptionList.isNotEmpty?ListView.builder(
          scrollDirection: Axis.vertical,
          primary: true,
          itemCount: _prescriptionsResponse.data.prescriptionList.length,
          itemBuilder: (BuildContext context, int index) {
            return PrescriptionItems(_prescriptionsResponse.data.prescriptionList[index]);
          }):Center(child: Text('No Prescription')):Center(child:circulerLoading()),
    );
  }
}
