import 'package:flutter/material.dart';
import 'package:pong/homescreen.dart';
import 'package:pong/game_zone/playground.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
  '/': (context) => HomeScreen(),
  '/play': (context) => Playground(),
  }
));

