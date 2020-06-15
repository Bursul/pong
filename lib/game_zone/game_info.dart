import 'package:flutter/material.dart';


class Score extends StatelessWidget {
  const Score({
    Key key,
    @required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 25,
      right: 25,
      child: Text(
        'Score: ' + score.toString(),
        style: TextStyle(
            fontSize: 25,
            fontFamily: 'Indies',
            fontWeight: FontWeight.bold,
            color: Colors.grey[300]),
      ),
    );
  }
}


class Level extends StatelessWidget {
  const Level({
    Key key,
    @required this.level,
  }) : super(key: key);

  final int level;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 55,
      right: 25,
      child: Text(
        'Level: ' + level.toString(),
        style: TextStyle(
            fontSize: 25,
            fontFamily: 'Indies',
            fontWeight: FontWeight.bold,
            color: Colors.grey[300]),
      ),
    );
  }
}