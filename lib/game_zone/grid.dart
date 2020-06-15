import 'package:flutter/material.dart';
import 'package:pong/game_zone/game_info.dart';
import 'ball.dart';
import 'bat.dart';
import 'dart:math';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  int score = 0;
  int level = 0;
  double diameter = 50;
  double batWidthMultiplicator = 3;
  double ballSpeed = 5;

  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  Animation<double> animation;
  AnimationController controller;

  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;

  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  double randX = 1;
  double randY = 1;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(minutes: 10000), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        (hDir == Direction.right) ? posX += ballSpeed : posX -= ballSpeed;
        (vDir == Direction.down) ? posY += ballSpeed : posY -= ballSpeed;
      });

      // (hDir == Direction.right)
      //       ? posX += ((ballSpeed * randX).round())
      //       : posX -= ((ballSpeed * randX).round());
      //   (vDir == Direction.down)
      //       ? posY += ((ballSpeed * randY).round())
      //       : posY -= ((ballSpeed * randY).round());
      // });

      checkBorders();
    });

    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        batWidth = width / batWidthMultiplicator;
        batHeight = height / 20;
        return Stack(
          children: <Widget>[
            Score(score: score,),
            Level(level: level),
            Positioned(
              child: Ball(),
              top: posY,
              left: posX,
            ),
            Positioned(
              bottom: 1,
              left: batPosition,
              child: GestureDetector(
                  onHorizontalDragUpdate: (DragUpdateDetails update) =>
                      moveBat(update),
                  child: Bat(batWidth, batHeight)),
            )
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
      randX = randomNumber();
    }
    if (posX >= width - diameter && hDir == Direction.right) {
      hDir = Direction.left;
      randX = randomNumber();
    }
    if (posY >= height - diameter - batHeight * 0.75 &&
        vDir == Direction.down) {
      if (posX >= (batPosition - diameter) &&
          posX <= (batPosition + batWidth)) {
        vDir = Direction.up;
        randY = randomNumber();
        safeSetState(() {
          score++;
          makeGameHarder();
        });
      } else {
        if (posY >= height - diameter) {
          controller.stop();
          showStartAgainMessage(context);
        }
      }
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
      randY = randomNumber();
    }
  }

  void makeGameHarder() {
    if (score % 5 == 0) {
      ballSpeed += 2.5;
      level++;
      if (score % 10 == 0) {
        batWidthMultiplicator++;
      }
    }
  }

  void moveBat(DragUpdateDetails updateDetails) {
    safeSetState(() {
      batPosition += updateDetails.delta.dx;
    });
  }

  void safeSetState(Function function) {
    if (mounted && controller.isAnimating) {
      setState(() {
        function();
      });
    }
  }

  double randomNumber() {
    var ran = new Random();
    int myNum = ran.nextInt(101);
    return (50 + myNum) / 100;
  }

  void showStartAgainMessage(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over!'),
            content: Text('Would You like to play again?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  setState(() {
                    setInitialBoardState();
                  });
                  Navigator.of(context).pop();
                  controller.repeat();
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () {
                  Navigator.popAndPushNamed(context, '/');
                },
              )
            ],
          );
        });
  }

  void setInitialBoardState() {
    posX = 0;
    posY = 0;
    score = 0;
    level = 0;
    batWidthMultiplicator = 3;
    ballSpeed = 5;
  }
}


