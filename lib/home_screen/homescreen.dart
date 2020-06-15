import 'package:flutter/material.dart';
import 'package:pong/buttons/exit_button.dart';
import 'package:pong/buttons/play_button.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
            Colors.blue[200],
            Colors.blue,
            Colors.indigo,
          ])),
      child: SafeArea(
        child: Center(
          child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GameName(),
            SizedBox(height: 60),
            PlayButton(),
            SizedBox(height: 30),
            ExitButton(),
          ],
        )),
      ),
    ));
  }
}

class GameName extends StatelessWidget {
  const GameName({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: Text(
        'Simple Pong',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 50,
            fontFamily: 'Indies',
            color: Colors.indigo),
      ),
    );
  }
}


