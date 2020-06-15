import 'package:flutter/material.dart';
import 'package:pong/game_zone/game_info.dart';
import 'ball.dart';
import 'bat.dart';

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

  Direction verticalDirection = Direction.down;
  Direction horizontalDirection = Direction.right;

  Animation<double> animation;
  AnimationController controller;

  double width = 0;
  double height = 0;
  double posX = 0;
  double posY = 0;

  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(minutes: 10000), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      safeSetState(() {
        moveBall();
      });
      checkBorders();
    });

    controller.forward();
    super.initState();
  }

  void moveBall() {
    (horizontalDirection == Direction.right) ? posX += ballSpeed : posX -= ballSpeed;
    (verticalDirection == Direction.down) ? posY += ballSpeed : posY -= ballSpeed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[800],
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          height = constraints.maxHeight;
          width = constraints.maxWidth;
          batWidth = width / batWidthMultiplicator;
          batHeight = height / 20;
          return Stack(
            children: <Widget>[
              Score(score: score),
              Level(level: level),
              Positioned(
                child: Ball(diameter),
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
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void checkBorders() {
    if (posX <= 0 && horizontalDirection == Direction.left) {
      horizontalDirection = Direction.right;
    }
    if (posX >= width - diameter && horizontalDirection == Direction.right) {
      horizontalDirection = Direction.left;
    }
    if (posY >= height - diameter - batHeight * 0.75 &&
        verticalDirection == Direction.down) {
      if (ballTouchesBat()) {
        verticalDirection = Direction.up;
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
    if (posY <= 0 && verticalDirection == Direction.up) {
      verticalDirection = Direction.down;
    }
  }

  bool ballTouchesBat() {
    return posX >= (batPosition - diameter) &&
        posX <= (batPosition + batWidth);
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
    batPosition = width / 2 - batWidth / 2;
  }
}
