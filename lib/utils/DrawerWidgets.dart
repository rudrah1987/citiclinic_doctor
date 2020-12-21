import 'package:city_clinic_doctor/ui/profile/ProfileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'Colors.dart';
import 'SvgImages.dart';

// In flutter start of function ->   _means private property or field or without underscore its value is public....

//Dashboard Navigation drawer items widget here......
Widget createDrawerItems(BuildContext context, String title, GestureTapCallback onTap){
  return ListTile(
    visualDensity: VisualDensity(horizontal: 0, vertical: -3),
//              dense:true,
//              contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
    title: Text(title),
    trailing: Icon(Icons.arrow_right),
    onTap: onTap
  );
}
