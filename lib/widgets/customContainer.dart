import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustomContainer extends StatelessWidget {
  Icon icon;
   CustomContainer({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey[700],
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: icon
    );
  }
}
