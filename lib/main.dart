import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.cyan[600],
        appBar: AppBar(
          title: const Text('Dice Game'),
          backgroundColor: Colors.cyan[800],
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 10,
        ),
        body: const DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  State<DicePage> createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int leftDiceNumber = 1;
  int rightDiceNumber = 1;

  int leftDiceFlex = 1;
  int rightDiceFlex = 1;

  void rollDice() {
    setState(() {
      leftDiceFlex = 1;
      rightDiceFlex = 1;
    });

    for (int i = 0; i < Random().nextInt(21) + 10; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        setState(() {
          var random = Random();
          leftDiceNumber = random.nextInt(6) + 1;
          rightDiceNumber = random.nextInt(6) + 1;

          if (leftDiceNumber < rightDiceNumber) {
            leftDiceFlex = 4;
            rightDiceFlex = 5;
          } else if (leftDiceNumber > rightDiceNumber) {
            leftDiceFlex = 5;
            rightDiceFlex = 4;
          } else {
            leftDiceFlex = 1;
            rightDiceFlex = 1;
          }
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                flex: leftDiceFlex,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset('images/dice$leftDiceNumber.png'),
                ),
              ),
              Expanded(
                flex: rightDiceFlex,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Image.asset('images/dice$rightDiceNumber.png'),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 70.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile view
                return TextButton(
                  onPressed: rollDice,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.tealAccent.withOpacity(0.3),
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.white, width: 3.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Roll Dice',
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                // Tablet view
                return TextButton(
                  onPressed: rollDice,
                  style: ButtonStyle(
                    foregroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                    overlayColor: MaterialStateColor.resolveWith(
                      (states) => Colors.tealAccent.withOpacity(0.3),
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (states) => RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(color: Colors.white, width: 5.0),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Roll Dice',
                    style: TextStyle(fontSize: 40),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
