import 'package:city_clinic_doctor/modal/consultationRequest/videoCRModel.dart';
import 'package:city_clinic_doctor/ui/home/consultationRequest/fragment/ConsultDetailAccToType.dart';
import 'package:city_clinic_doctor/ui/home/consultationRequest/items/VideoCRItems.dart';
import 'package:flutter/material.dart';

class VideoCRPage extends StatefulWidget {
  @override
  _VideoCRPageState createState() => _VideoCRPageState();
}

class _VideoCRPageState extends State<VideoCRPage> {
  var listVideoCR = List<VideoCRModel>();

  @override
  void initState() {
    super.initState();

    listVideoCR.add(VideoCRModel("Akshit Kumar", "kumar.akshit34@gmail.com", "8890988343", "Male", "CD1234", "Video"));
    listVideoCR.add(VideoCRModel("Vikas Rohilla", "vikas.rohilla54@gmail.com", "9998837463", "Male", "CD5634", "Video"));
    listVideoCR.add(VideoCRModel("Gaurav Pandey", "gaurav.pandey98@gmail.com", "8976776473", "Male", "CD8474", "Video"));
    listVideoCR.add(VideoCRModel("Ajay Kulkarni", "kulkarni.ajay64@gmail.com", "7989984743", "Male", "CD2644", "Video"));
    listVideoCR.add(VideoCRModel("Ashish Arya", "arya.ashish55@gmail.com", "9999984743", "Male", "CD8844", "Video"));
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: listVideoCR.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: VideoCRItems(listVideoCR[index]),
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ConsultDetailAcToType(listVideoCR[index])));
            },
          );
        });
  }
}
