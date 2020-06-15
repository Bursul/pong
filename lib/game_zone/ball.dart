import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  
  final double diameter;

  Ball(this.diameter);

  @override
  Widget build(BuildContext context) {
     return Container(
      width: diameter,
      height: diameter,
      decoration: new BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
      ),
    );
  }
}
