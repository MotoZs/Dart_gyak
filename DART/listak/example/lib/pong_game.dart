import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class PongGame extends StatefulWidget {
  const PongGame({Key? key}) : super(key: key);

  @override
  State<PongGame> createState() => _PongGameState();
}

class _PongGameState extends State<PongGame> {
  double ballX = 0;
  double ballY = 0;
  double ballSpeedX = 2;
  double ballSpeedY = 2;
  double paddle1Y = 0;
  double paddle2Y = 0;
  int score1 = 0;
  int score2 = 0;
  late Timer gameTimer;
  bool isGameRunning = false;
  final double paddleHeight = 80;
  final double paddleWidth = 15;
  final double ballSize = 15;
  final double gameWidth = 600;
  final double gameHeight = 400;
  double speedMultiplier = 1.0;
  int hitCount = 0;

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  void startGame() {
    if (isGameRunning) return;
    setState(() {
      isGameRunning = true;
    });
    gameTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      updateGame();
    });
  }

  void pauseGame() {
    if (!isGameRunning) return;
    gameTimer.cancel();
    setState(() {
      isGameRunning = false;
    });
  }

  void resetGame() {
    if (gameTimer.isActive) gameTimer.cancel();
    setState(() {
      ballX = 0;
      ballY = 0;
      ballSpeedX = 2;
      ballSpeedY = 2;
      paddle1Y = 0;
      paddle2Y = 0;
      score1 = 0;
      score2 = 0;
      isGameRunning = false;
      speedMultiplier = 1.0;
      hitCount = 0;
    });
  }

  void updateGame() {
    setState(() {
      ballX += ballSpeedX;
      ballY += ballSpeedY;

      if (ballY <= -gameHeight / 2 || ballY >= gameHeight / 2) {
        ballSpeedY = -ballSpeedY;
      }

      if (ballX <= -gameWidth / 2 + paddleWidth &&
          ballY >= paddle1Y &&
          ballY <= paddle1Y + paddleHeight) {
        ballSpeedX = -ballSpeedX;
        hitCount++;
        speedMultiplier = 1.0 + (hitCount * 0.1);
        ballSpeedX =
            ballSpeedX.abs() * (ballSpeedX < 0 ? -1 : 1) * speedMultiplier;
        ballSpeedY *= speedMultiplier;
      }

      if (ballX >= gameWidth / 2 - paddleWidth &&
          ballY >= paddle2Y &&
          ballY <= paddle2Y + paddleHeight) {
        ballSpeedX = -ballSpeedX;
        hitCount++;
        speedMultiplier = 1.0 + (hitCount * 0.1);
        ballSpeedX =
            ballSpeedX.abs() * (ballSpeedX < 0 ? -1 : 1) * speedMultiplier;
        ballSpeedY *= speedMultiplier;
      }

      if (ballX < -gameWidth / 2) {
        score2++;
        resetBall();
      }

      if (ballX > gameWidth / 2) {
        score1++;
        resetBall();
      }
    });
  }

  void resetBall() {
    ballX = 0;
    ballY = 0;
    ballSpeedX = 2 * speedMultiplier;
    ballSpeedY = 2 * speedMultiplier;
    hitCount = 0;
  }

  void movePaddle1Up() {
    setState(() {
      if (paddle1Y > -gameHeight / 2) {
        paddle1Y -= 20;
      }
    });
  }

  void movePaddle1Down() {
    setState(() {
      if (paddle1Y < gameHeight / 2 - paddleHeight) {
        paddle1Y += 20;
      }
    });
  }

  void movePaddle2Up() {
    setState(() {
      if (paddle2Y > -gameHeight / 2) {
        paddle2Y -= 20;
      }
    });
  }

  void movePaddle2Down() {
    setState(() {
      if (paddle2Y < gameHeight / 2 - paddleHeight) {
        paddle2Y += 20;
      }
    });
  }

  @override
  void dispose() {
    if (gameTimer.isActive) gameTimer.cancel();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: _focusNode,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.keyW)) {
          movePaddle1Up();
        } else if (event.isKeyPressed(LogicalKeyboardKey.keyS)) {
          movePaddle1Down();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
          movePaddle2Up();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
          movePaddle2Down();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('PONG Game - 2 Player')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Scores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Player 1 (W/S): $score1',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Player 2 (↑/↓): $score2',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Game Board
            Container(
              width: gameWidth,
              height: gameHeight,
              color: Colors.black,
              child: Stack(
                children: [
                  // Ball
                  Positioned(
                    left: ballX + gameWidth / 2,
                    top: ballY + gameHeight / 2,
                    child: Container(
                      width: ballSize,
                      height: ballSize,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(ballSize / 2),
                      ),
                    ),
                  ),
                  // Paddle 1 (Left)
                  Positioned(
                    left: 0,
                    top: paddle1Y + gameHeight / 2,
                    child: Container(
                      width: paddleWidth,
                      height: paddleHeight,
                      color: Colors.blue,
                    ),
                  ),
                  // Paddle 2 (Right)
                  Positioned(
                    right: 0,
                    top: paddle2Y + gameHeight / 2,
                    child: Container(
                      width: paddleWidth,
                      height: paddleHeight,
                      color: Colors.red,
                    ),
                  ),
                  // Center line
                  Positioned(
                    left: gameWidth / 2 - 1,
                    top: 0,
                    child: Container(
                      width: 2,
                      height: gameHeight,
                      color: Colors.white30,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Control Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: isGameRunning ? pauseGame : startGame,
                  icon: Icon(isGameRunning ? Icons.pause : Icons.play_arrow),
                  label: Text(isGameRunning ? 'Pause' : 'Play'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton.icon(
                  onPressed: resetGame,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Instructions
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Controls:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text('Player 1 (Blue):  W = Up, S = Down'),
                  Text('Player 2 (Red):   ↑ = Up, ↓ = Down'),
                  Text('Or use buttons to Play/Pause and Reset'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
