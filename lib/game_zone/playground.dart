import 'package:flutter/material.dart';
import 'grid.dart';

class Playground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Pong(),
      ),
    );
  }
}
