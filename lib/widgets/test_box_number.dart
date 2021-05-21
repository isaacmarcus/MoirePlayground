import 'package:flutter/material.dart';

class TestBoxNumber extends StatelessWidget {
  final List numberDisplay;
  final int boxIndex;

  TestBoxNumber({required this.numberDisplay, required this.boxIndex});

  Widget build(BuildContext context) {
    return Text(this.numberDisplay[this.boxIndex].toString());
  }
}
