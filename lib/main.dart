import 'package:flutter/material.dart';
import 'package:pong/game_zone/playground.dart';
import 'package:pong/home_screen/homescreen.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
  '/': (context) => HomeScreen(),
  '/play': (context) => Playground(),
  }
));

