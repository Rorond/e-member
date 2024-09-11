import 'package:emembers/core/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  CircularButton(
      {required this.text,
      required this.onPressed,
      this.color = Colors.white,
      required this.borderColor,
      this.textColor = Colors.black});

  final String text;
  final Color color;
  final Color borderColor;
  final Color textColor;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        this.onPressed();
      },
      child: Container(
          width: 140,
          height: 140,
          padding: EdgeInsets.all(5),
          decoration: new BoxDecoration(
            // Circle shape
            shape: BoxShape.circle,
            color: color,
            // The border you want
            border: new Border.all(
              width: 5.0,
              color: borderColor ?? theme.radiantRed,
            ),
          ),
          child: Center(
            child: Text(
              '${this.text}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, color: textColor),
            ),
          )),
    );
  }
}
