import 'package:city_clinic_doctor/modal/prescriptions/prescriptions.dart';
import 'package:city_clinic_doctor/network/api_provider.dart';
import 'package:city_clinic_doctor/new/customs/custom_methods.dart';
import 'package:city_clinic_doctor/ui/drawer/prescriptionManagement/PrescriptionItems.dart';
import 'package:flutter/material.dart';

class PrescriptionPage extends StatefulWidget {
  static const String routeName = '/prescriptionManagementWithAppBar';
  @override
  _PrescriptionPageState createState() => _PrescriptionPageState();
}

class _PrescriptionPageState extends State<PrescriptionPage> {
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
    return !isLoading?_prescriptionsResponse.data.prescriptionList.isNotEmpty?ListView.builder(
          scrollDirection: Axis.vertical,
          primary: true,
          itemCount: _prescriptionsResponse.data.prescriptionList.length,
          itemBuilder: (BuildContext context, int index) {
            return PrescriptionItems(_prescriptionsResponse.data.prescriptionList[index]);
          }):Center(child: Text('No Prescription')):Center(child:circulerLoading());

  }
}
