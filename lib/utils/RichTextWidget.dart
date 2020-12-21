import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String firstText;
  final String secondText;

  RichTextWidget(this.firstText, this.secondText);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: new TextSpan(
      text: firstText,
      style: TextStyle(fontSize: 12, color: Colors.grey,
          decoration: TextDecoration.underline),
      children: <TextSpan>[
        TextSpan(
            text: secondText,
            style: new TextStyle(fontSize: 12,
                // fontWeight: FontWeight.bold,
                color: Colors.black87,
                decoration: TextDecoration.underline)),
      ],
    ));
  }
}
