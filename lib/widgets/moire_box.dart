import 'package:flutter/material.dart';
import 'package:moire_app/constants.dart';

class MoireBox extends StatefulWidget {
  int numberOfBoxes;
  var borderColour;
  double xPosition;
  double yPosition;
  final BuildContext scrnContext;
  double xWidth;
  double yHeight;

  MoireBox({
    required this.numberOfBoxes,
    required this.borderColour,
    this.xPosition = 0,
    this.yPosition = 0,
    required this.scrnContext,
    this.xWidth = 0,
    this.yHeight = 0,
  });

  void setXPosition(val) {
    xPosition = val;
  }

  void setYPosition(val) {
    yPosition = val;
  }

  void setXWidth(val) {
    xWidth = val;
  }

  void setYHeight(val) {
    yHeight = val;
  }

  double getXPosition(val) {
    return this.xPosition.toDouble();
  }

  double getYPosition(val) {
    return this.yPosition.toDouble();
  }

  double getXWidth(val) {
    return this.xWidth.toDouble();
  }

  double getYHeight(val) {
    return this.yHeight.toDouble();
  }

  @override
  _MoireBoxState createState() => _MoireBoxState();
}

class _MoireBoxState extends State<MoireBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _buildBoxes(),
    );
  }

  List<Widget> _buildBoxes() {
    // query to get screen sizes
    double screenWidth = MediaQuery.of(widget.scrnContext).size.width;
    double screenHeight = MediaQuery.of(widget.scrnContext).size.height;
    // list to contain container widgets
    List<Widget> boxList = [];
    // default box width and heights
    double boxWidth = screenWidth * 0.75;
    double boxHeight = screenHeight * 0.8;
    //  margins
    double leftMargin = ((screenWidth - boxWidth) / 2) + widget.xPosition;
    double rightMargin = ((screenWidth - boxWidth) / 2) - widget.xPosition;
    double topMargin = ((screenHeight - boxHeight) / 2) + widget.yPosition;
    double botMargin = ((screenHeight - boxHeight) / 2) +
        screenHeight * 0.05 -
        widget.yPosition;

    if (widget.xWidth != 0) {
      leftMargin = ((screenWidth - widget.xWidth) / 2) + widget.xPosition;
      rightMargin = ((screenWidth - widget.xWidth) / 2) - widget.xPosition;
    }

    if (widget.yHeight != 0) {
      topMargin = ((screenHeight - widget.yHeight) / 2) - widget.yPosition;
      botMargin = ((screenHeight - widget.yHeight) / 2) +
          screenHeight * 0.05 +
          widget.yPosition;
    }

    // inner starting margins
    double hMargin = 5;
    double vMargin = 8;
    // for loop to build containers
    for (int i = 0; i < widget.numberOfBoxes; i++) {
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
            border: Border.all(
              color: widget.borderColour,
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
