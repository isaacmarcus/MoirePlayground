import 'package:flutter/material.dart';
import 'package:moire_app/constants.dart';

class MoireBox extends StatelessWidget {
  final int numberOfBoxes;
  final borderColour;
  final double xPosition;
  final double yPosition;
  final BuildContext scrnContext;
  final double boxWidth;
  final double boxHeight;
  final double boxRadius;

  MoireBox({
    required this.borderColour,
    required this.boxHeight,
    required this.boxWidth,
    required this.numberOfBoxes,
    required this.scrnContext,
    required this.xPosition,
    required this.yPosition,
    required this.boxRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildBoxes(),
    );
  }

  List<Widget> _buildBoxes() {
    // query to get screen sizes
    double screenWidth = MediaQuery.of(scrnContext).size.width;
    double screenHeight = MediaQuery.of(scrnContext).size.height;
    // list to contain container widgets
    List<Widget> boxList = [];
    // default box width and heights
    // double boxWidth = screenWidth * 0.75;
    // double boxHeight = screenHeight * 0.8;
    //  margins
    double leftMargin = ((screenWidth - boxWidth) / 2) + xPosition;
    double rightMargin = ((screenWidth - boxWidth) / 2) - xPosition;
    double topMargin = ((screenHeight - boxHeight) / 2) + yPosition;
    double botMargin =
        ((screenHeight - boxHeight) / 2) + screenHeight * 0.05 - yPosition;

    if (boxWidth != 0) {
      leftMargin = ((screenWidth - boxWidth) / 2) + xPosition;
      rightMargin = ((screenWidth - boxWidth) / 2) - xPosition;
    }

    if (boxHeight != 0) {
      topMargin = ((screenHeight - boxHeight) / 2) - yPosition;
      botMargin =
          ((screenHeight - boxHeight) / 2) + screenHeight * 0.05 + yPosition;
    }

    // inner starting margins
    double hMargin = 5;
    double vMargin = 8;

    // for loop to build containers
    for (int i = 0; i < numberOfBoxes; i++) {
      if (leftMargin + rightMargin >= screenWidth ||
          topMargin + botMargin + 60 >= screenHeight) {
        // print("margin limit reached, cutting off extra boxes");
        break;
      }

      boxList.add(
        Container(
          margin: EdgeInsets.fromLTRB(
              leftMargin, topMargin, rightMargin, botMargin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(this.boxRadius)),
            border: Border.all(
              color: borderColour,
              width: 0.5,
            ),
          ),
        ),
      );
      leftMargin += hMargin;
      rightMargin += hMargin;
      topMargin += vMargin;
      botMargin += vMargin;
      if (hMargin > 0) {
        hMargin -= 0.06;
      }
      if (vMargin > 0) {
        vMargin -= 0.08;
      }
      if (hMargin == 0 || hMargin <= 0) {
        print("hmargin is 0");
        break;
      }
    }
    return boxList;
  }
}
