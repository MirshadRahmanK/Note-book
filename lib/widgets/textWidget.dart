import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomTxt extends StatelessWidget {
  Color color;
   CustomTxt({required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Note Book",
      style: TextStyle(
          fontSize: 25, fontWeight: FontWeight.bold, color: color),
    );
  }
}
