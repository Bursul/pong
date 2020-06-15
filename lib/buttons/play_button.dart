import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/play');
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.blue[300],
                Colors.blue[800],
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(80.0))),
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
        child: const Text('Play', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
