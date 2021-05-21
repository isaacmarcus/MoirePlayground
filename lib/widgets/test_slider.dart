import 'package:flutter/material.dart';

import '../constants.dart';

class TestSlider extends StatefulWidget {
  List testValue;
  dynamic updateFunc;
  int boxIndex;

  TestSlider({
    required this.testValue,
    required this.updateFunc,
    required this.boxIndex,
  });

  @override
  _TestSliderState createState() => _TestSliderState();
}

class _TestSliderState extends State<TestSlider> {
  // double curValue = widget.testValue;

  @override
  Widget build(BuildContext context) {
    double curValue = widget.testValue[widget.boxIndex];

    return Slider(
      activeColor: themeData.primaryColorLight,
      value: curValue,
      min: 0,
      max: 100,
      divisions: 50,
      label: curValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          curValue = value;
        });
        widget.updateFunc(widget.boxIndex, value);
      },
    );
  }
}
