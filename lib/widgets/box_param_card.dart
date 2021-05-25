import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../constants.dart';

// ignore: must_be_immutable
class BoxParamCard extends StatefulWidget {
  BuildContext ctx;
  Function updateParam;
  List paramList;
  int boxIndex;

  BoxParamCard(
      {required this.ctx,
      required this.paramList,
      required this.updateParam,
      required this.boxIndex});

  @override
  _BoxParamCardState createState() => _BoxParamCardState();
}

class _BoxParamCardState extends State<BoxParamCard> {
  @override
  Widget build(BuildContext context) {
    // Box index
    int boxIndex = widget.boxIndex;
    // get variables from parameter list
    double _xPosition = widget.paramList[boxIndex][0];
    double _yPosition = widget.paramList[boxIndex][1];
    double _boxWidth = widget.paramList[boxIndex][2];
    double _boxHeight = widget.paramList[boxIndex][3];
    double _numOfBoxes = widget.paramList[boxIndex][4];
    double _boxRadius = widget.paramList[boxIndex][6];
    Color _currentColor = widget.paramList[boxIndex][5];

    // calculate screenwidth and height
    double _screenWidth = MediaQuery.of(widget.ctx).size.width;
    double _screenHeight = MediaQuery.of(widget.ctx).size.height;
    // setting up values for x/y position slider minmax
    double _xMinPos = -((_screenWidth / 2) - (_boxWidth / 2) - kSymPadValueS);
    double _xMaxPos = (_screenWidth / 2) - (_boxWidth / 2) - kSymPadValueS;
    double _yMinPos = -((_screenHeight / 2) - (_boxHeight / 2) - kSymPadValueS);
    double _yMaxPos = (_screenHeight / 2) - (_boxHeight / 2) - kSymPadValueS;

    return Column(
      children: [
        Center(
          child: Text(
            "Box Number #" + (boxIndex + 1).toString(),
            style: themeData.textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Box Width:",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** Box Width Slider
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _boxWidth,
              min: 100,
              max: (_screenWidth) - (kSymPadValueS * 2),
              onChanged: (double value) {
                setState(() {
                  if (_xPosition <=
                      -((_screenWidth / 2) - (value / 2) - kSymPadValueS)) {
                    widget.updateParam(boxIndex, 0,
                        -((_screenWidth / 2) - (value / 2) - kSymPadValueS));
                  }
                  if (_xPosition >=
                      (_screenWidth / 2) - (value / 2) - kSymPadValueS) {
                    widget.updateParam(boxIndex, 0,
                        (_screenWidth / 2) - (value / 2) - kSymPadValueS);
                  }
                  widget.updateParam(boxIndex, 2, value);
                });
              },
            ),
            Text(
              _boxWidth.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Box Height:",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** Box Height Slider
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _boxHeight,
              min: 100,
              max: (_screenHeight - _screenHeight * 0.05 - kSymPadValueS),
              onChanged: (double value) {
                setState(() {
                  if (_yPosition <=
                      -((_screenHeight / 2) - (value / 2) - kSymPadValueS)) {
                    widget.updateParam(boxIndex, 1,
                        -((_screenHeight / 2) - (value / 2) - kSymPadValueS));
                  }
                  if (_yPosition >=
                      (_screenHeight / 2) - (value / 2) - kSymPadValueS) {
                    widget.updateParam(boxIndex, 1,
                        (_screenHeight / 2) - (value / 2) - kSymPadValueS);
                  }
                  widget.updateParam(boxIndex, 3, value);
                });
              },
            ),
            Text(
              _boxHeight.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "X Position:",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** X Position Slider **
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _xPosition,
              min: _xMinPos,
              max: _xMaxPos,
              onChanged: (double value) {
                setState(() {
                  widget.updateParam(boxIndex, 0, value);
                });
              },
            ),
            Text(
              _xPosition.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Y Position:",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** Y Position Slider **
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _yPosition,
              min: _yMinPos,
              max: _yMaxPos,
              onChanged: (double value) {
                setState(() {
                  widget.updateParam(boxIndex, 1, value);
                });
              },
            ),
            Text(
              _yPosition.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No. of Boxes:",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** Y Position Slider **
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _numOfBoxes,
              min: 1,
              max: 100,
              onChanged: (double value) {
                setState(() {
                  widget.updateParam(boxIndex, 4, value.round());
                });
              },
            ),
            Text(
              _numOfBoxes.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Box Radius (Curve):",
              style: themeData.textTheme.bodyText1,
            ),
            SizedBox(
              width: 10,
            ),
            // ** Y Position Slider **
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _boxRadius,
              min: 0,
              max: 1000,
              onChanged: (double value) {
                setState(() {
                  widget.updateParam(boxIndex, 6, value.round());
                });
              },
            ),
            Text(
              _boxRadius.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Colour of Boxes:",
              style: themeData.textTheme.bodyText1,
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0.0),
                      contentPadding: const EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: _currentColor,
                          onColorChanged: (color) {
                            setState(() {
                              widget.updateParam(boxIndex, 5, color);
                            });
                          },
                          paletteType: PaletteType.rgb,
                          enableAlpha: false,
                          displayThumbColor: true,
                          showLabel: false,
                          showIndicator: true,
                          indicatorBorderRadius: const BorderRadius.vertical(
                            top: const Radius.circular(15.0),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.circle,
                color: _currentColor,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
