import 'package:city_clinic_doctor/ui/home/consultationRequest/items/AudioCRItems.dart';
import 'package:flutter/material.dart';

class AudioCRPage extends StatefulWidget {
  @override
  _AudioCRPageState createState() => _AudioCRPageState();
}

class _AudioCRPageState extends State<AudioCRPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        primary: true,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return AudioCRItems();
        });
  }
}
