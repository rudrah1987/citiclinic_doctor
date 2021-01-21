

import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

tGotoPush(ctx,page){
  Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=>page));
}

void successDialog({@required context,@required svgName}) {
  showDialog(
      context: context,
      builder: (BuildContext bc) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          elevation: 16,
          child: Container(
              height: 280.0,
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.circular(100)),
              child: SvgPicture.asset(svgName, height:100, width:100,)
          ),
        );
      }
  );
}
circulerLoading() {
  return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)
  );
}