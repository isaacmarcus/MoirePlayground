import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moire_app/widgets/master_app_bar.dart';
import 'package:moire_app/widgets/menu_drawer.dart';
import 'package:moire_app/widgets/moire_box.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:math' as math;

import '../constants.dart';

/* --------------------------------------------------------------------------

Page Title: Moire Page
Widget Description: page to play

-----------------------------------------------------------------------------*/

class MoirePage extends StatefulWidget {
  static const String id = "moire_page";

  @override
  _MoirePageState createState() => _MoirePageState();
}

class _MoirePageState extends State<MoirePage>
    with SingleTickerProviderStateMixin {
  // class variables
  late AnimationController _drawerSlideController;
  double xPositionValue1 = 0;
  double yPositionValue1 = 0;
  double boxWidth1 = 200;
  double boxHeight1 = 200;
  double xPositionValue2 = 0;
  double yPositionValue2 = 0;
  double boxWidth2 = 200;
  double boxHeight2 = 200;
  List masterBoxList = [];
  List masterParamList = [];

  @override
  void initState() {
    super.initState();
    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
    _drawerSlideController.dispose();
    super.dispose();
  }

  bool _isDrawerClosed() {
    return _drawerSlideController.value == 0.0;
  }

  void addMoireBox(BuildContext _ctx) {
    double _xPositionValue = 0;
    double _yPositionValue = 0;
    double _boxWidth = 200;
    double _boxHeight = 200;
    masterParamList.add([0, 0, 200, 200]);
    final paramListInd = masterParamList.length - 1;

    MoireBox curMoireBox = MoireBox(
      scrnContext: _ctx,
      xPosition: masterParamList[paramListInd][0],
      yPosition: masterParamList[paramListInd][1],
      xWidth: masterParamList[paramListInd][2],
      yHeight: masterParamList[paramListInd][3],
      numberOfBoxes: 20,
      borderColour: Colors.redAccent,
    );

    masterBoxList.add([
      curMoireBox,
      _boxParams(
        _ctx,
        curMoireBox,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    MoireBox testBox = MoireBox(
      scrnContext: context,
      xPosition: xPositionValue1,
      yPosition: yPositionValue1,
      xWidth: boxWidth1,
      yHeight: boxHeight1,
      numberOfBoxes: 70,
      borderColour: Colors.redAccent,
    );

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       addMoireBox(context);
      //     });
      //   },
      // ),
      appBar: PreferredSize(
        child: MasterAppBar(drawerSlideController: _drawerSlideController),
        preferredSize: MediaQuery.of(context).size.width >= 725
            ? kAppBarHeightS
            : kAppBarHeightS,
      ),
      extendBodyBehindAppBar: false,
      body: Stack(
        children: [
          MoireBox(
            scrnContext: context,
            xPosition: xPositionValue2,
            yPosition: yPositionValue2,
            xWidth: boxWidth2,
            yHeight: boxHeight2,
            numberOfBoxes: 70,
            borderColour: Colors.amber,
          ),
          testBox,
          _buildMoireBoxes(context),
          // MoireBox(
          //   scrnContext: context,
          //   xPosition: 0,
          //   numberOfBoxes: 70,
          //   borderColour: Colors.amber,
          // ),
          // Main page body content
          _buildContent(),
          _buildDrawer(),
          _buildSlideUpPanel(),
        ],
      ),
    );
  }

  // Page Content
  Widget _buildContent() {
    return Padding(
      padding: MediaQuery.of(context).size.width >= 725
          ? kMasterPaddingL
          : kMasterPaddingS,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[],
      ),
    );
  }

  Widget _buildDrawer() {
    return AnimatedBuilder(
      animation: _drawerSlideController,
      builder: (context, child) {
        return FractionalTranslation(
          translation: Offset(1.0 - _drawerSlideController.value, 0.0),
          child: _isDrawerClosed()
              ? const SizedBox()
              : Menu(
                  dsController: _drawerSlideController,
                ),
        );
      },
    );
  }

  Widget _buildMoireBoxes(BuildContext _ctx) {
    List<Widget> _boxList = [];
    for (int i = 0; i < masterBoxList.length; i++) {
      _boxList.add(masterBoxList[i][0]);
    }
    return Stack(
      children: _boxList,
    );
  }

  Widget _buildBoxParams(BuildContext _ctx) {
    return new ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: masterBoxList.length,
      itemBuilder: (BuildContext _ctx, int index) {
        return masterBoxList[index][1];
      },
    );
  }

  Widget _buildSlideUpPanel() {
    // calculate screenwidth and height
    // double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // setting up values for x/y position slider minmax
    // double xMinPos1 = -((screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS);
    // double xMaxPos1 = (screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS;
    // double yMinPos1 = -((screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS);
    // double yMaxPos1 = (screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS;

    return SlidingUpPanel(
      parallaxEnabled: true,
      parallaxOffset: 0.5,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
      boxShadow: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.15),
          blurRadius: 0.5,
        ),
      ],
      color: Colors.transparent,
      minHeight: screenHeight * 0.05,
      maxHeight: screenHeight * 0.5,
      panelBuilder: (sc) => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          controller: sc,
          children: <Widget>[
            // sized box to responsively increase/decrease margin according to screen size
            SizedBox(
              height: screenHeight * 0.05 / 2,
            ),
            // Pull up bar icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[500],
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05 / 2,
            ),
            // _boxParamsHC(context, testBox),

            _buildBoxParams(context),
            _boxParamsHC(context),
            _boxParamsHC2(context),
            // BOX PARAMETERS WIDGET
          ],
        ),
      ),
    );
  }

  Widget _boxParams(BuildContext _ctx, moireBox) {
    // get variables from moireBox
    double _xPositionValue = moireBox.getXPosition;
    double _yPositionValue = moireBox.getYPosition;
    double _boxWidth = moireBox.getXWidth;
    double _boxHeight = moireBox.getYHeight;
    print(_xPositionValue);
    // calculate screenwidth and height
    double _screenWidth = MediaQuery.of(_ctx).size.width;
    double _screenHeight = MediaQuery.of(_ctx).size.height;
    // setting up values for x/y position slider minmax
    double _xMinPos = -((_screenWidth / 2) - (_boxWidth / 2) - kSymPadValueS);
    double _xMaxPos = (_screenWidth / 2) - (_boxWidth / 2) - kSymPadValueS;
    double _yMinPos = -((_screenHeight / 2) - (_boxHeight / 2) - kSymPadValueS);
    double _yMaxPos = (_screenHeight / 2) - (_boxHeight / 2) - kSymPadValueS;

    return Column(
      children: [
        Center(
          child: Text(
            "Box Number #",
            style: themeData.textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 15,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _boxWidth,
              min: 100,
              max: (_screenWidth) - (kSymPadValueS * 2),
              onChanged: (double value) {
                setState(() {
                  if (_xPositionValue <=
                      -((_screenWidth / 2) - (value / 2) - kSymPadValueS)) {
                    _xPositionValue =
                        -((_screenWidth / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (_xPositionValue >=
                      (_screenWidth / 2) - (value / 2) - kSymPadValueS) {
                    _xPositionValue =
                        (_screenWidth / 2) - (value / 2) - kSymPadValueS;
                  }
                  _boxWidth = value;
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _boxHeight,
              min: 100,
              max: (_screenHeight - _screenHeight * 0.05 - kSymPadValueS),
              onChanged: (double value) {
                setState(() {
                  if (_yPositionValue <=
                      -((_screenHeight / 2) - (value / 2) - kSymPadValueS)) {
                    _yPositionValue =
                        -((_screenHeight / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (_yPositionValue >=
                      (_screenHeight / 2) - (value / 2) - kSymPadValueS) {
                    _yPositionValue =
                        (_screenHeight / 2) - (value / 2) - kSymPadValueS;
                  }
                  _boxHeight = value;
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _xPositionValue,
              min: _xMinPos,
              max: _xMaxPos,
              onChanged: (double value) {
                setState(() {
                  _xPositionValue = value;
                });
              },
            ),
            Text(
              _xPositionValue.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 10,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: _yPositionValue,
              min: _yMinPos,
              max: _yMaxPos,
              onChanged: (double value) {
                setState(() {
                  _yPositionValue = value;
                });
              },
            ),
            Text(
              _yPositionValue.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        )
      ],
    );
  }

  // HARDCODED
  Widget _boxParamsHC(BuildContext _ctx) {
    // get variables from moireBox
    // double _xPositionValue = moireBox.getXPosition;
    // double _yPositionValue = moireBox.getYPosition;
    // double _boxWidth = moireBox.getXWidth;
    // double _boxHeight = moireBox.getYHeight;
    // calculate screenwidth and height
    double _screenWidth = MediaQuery.of(_ctx).size.width;
    double _screenHeight = MediaQuery.of(_ctx).size.height;
    // setting up values for x/y position slider minmax
    double _xMinPos = -((_screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS);
    double _xMaxPos = (_screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS;
    double _yMinPos = -((_screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS);
    double _yMaxPos = (_screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS;

    return Column(
      children: [
        Center(
          child: Text(
            "Box Number #",
            style: themeData.textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 15,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: boxWidth1,
              min: 100,
              max: (_screenWidth) - (kSymPadValueS * 2),
              onChanged: (double value) {
                setState(() {
                  if (xPositionValue1 <=
                      -((_screenWidth / 2) - (value / 2) - kSymPadValueS)) {
                    xPositionValue1 =
                        -((_screenWidth / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (xPositionValue1 >=
                      (_screenWidth / 2) - (value / 2) - kSymPadValueS) {
                    xPositionValue1 =
                        (_screenWidth / 2) - (value / 2) - kSymPadValueS;
                  }
                  boxWidth1 = value;
                });
              },
            ),
            Text(
              boxWidth1.round().toString(),
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: boxHeight1,
              min: 100,
              max: (_screenHeight - _screenHeight * 0.05 - kSymPadValueS),
              onChanged: (double value) {
                setState(() {
                  if (yPositionValue1 <=
                      -((_screenHeight / 2) - (value / 2) - kSymPadValueS)) {
                    yPositionValue1 =
                        -((_screenHeight / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (yPositionValue1 >=
                      (_screenHeight / 2) - (value / 2) - kSymPadValueS) {
                    yPositionValue1 =
                        (_screenHeight / 2) - (value / 2) - kSymPadValueS;
                  }
                  boxHeight1 = value;
                });
              },
            ),
            Text(
              boxHeight1.round().toString(),
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: xPositionValue1,
              min: _xMinPos,
              max: _xMaxPos,
              onChanged: (double value) {
                setState(() {
                  xPositionValue1 = value;
                });
              },
            ),
            Text(
              xPositionValue1.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 10,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: yPositionValue1,
              min: _yMinPos,
              max: _yMaxPos,
              onChanged: (double value) {
                setState(() {
                  yPositionValue1 = value;
                });
              },
            ),
            Text(
              yPositionValue1.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        )
      ],
    );
  }

// HARDCODED 2

  Widget _boxParamsHC2(BuildContext _ctx) {
    // get variables from moireBox
    // double _xPositionValue = moireBox.getXPosition;
    // double _yPositionValue = moireBox.getYPosition;
    // double _boxWidth = moireBox.getXWidth;
    // double _boxHeight = moireBox.getYHeight;
    // calculate screenwidth and height
    double _screenWidth = MediaQuery.of(_ctx).size.width;
    double _screenHeight = MediaQuery.of(_ctx).size.height;
    // setting up values for x/y position slider minmax
    double _xMinPos = -((_screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS);
    double _xMaxPos = (_screenWidth / 2) - (boxWidth1 / 2) - kSymPadValueS;
    double _yMinPos = -((_screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS);
    double _yMaxPos = (_screenHeight / 2) - (boxHeight1 / 2) - kSymPadValueS;

    return Column(
      children: [
        Center(
          child: Text(
            "Box Number #",
            style: themeData.textTheme.headline5,
          ),
        ),
        SizedBox(
          height: 15,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: boxWidth2,
              min: 100,
              max: (_screenWidth) - (kSymPadValueS * 2),
              onChanged: (double value) {
                setState(() {
                  if (xPositionValue2 <=
                      -((_screenWidth / 2) - (value / 2) - kSymPadValueS)) {
                    xPositionValue2 =
                        -((_screenWidth / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (xPositionValue2 >=
                      (_screenWidth / 2) - (value / 2) - kSymPadValueS) {
                    xPositionValue2 =
                        (_screenWidth / 2) - (value / 2) - kSymPadValueS;
                  }
                  boxWidth2 = value;
                });
              },
            ),
            Text(
              boxWidth2.round().toString(),
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: boxHeight2,
              min: 100,
              max: (_screenHeight - _screenHeight * 0.05 - kSymPadValueS),
              onChanged: (double value) {
                setState(() {
                  if (yPositionValue2 <=
                      -((_screenHeight / 2) - (value / 2) - kSymPadValueS)) {
                    yPositionValue2 =
                        -((_screenHeight / 2) - (value / 2) - kSymPadValueS);
                  }
                  if (yPositionValue2 >=
                      (_screenHeight / 2) - (value / 2) - kSymPadValueS) {
                    yPositionValue2 =
                        (_screenHeight / 2) - (value / 2) - kSymPadValueS;
                  }
                  boxHeight2 = value;
                });
              },
            ),
            Text(
              boxHeight2.round().toString(),
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: xPositionValue2,
              min: _xMinPos,
              max: _xMaxPos,
              onChanged: (double value) {
                setState(() {
                  xPositionValue2 = value;
                });
              },
            ),
            Text(
              xPositionValue2.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        ),
        SizedBox(
          height: 10,
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
            Slider(
              activeColor: themeData.primaryColorLight,
              value: yPositionValue2,
              min: _yMinPos,
              max: _yMaxPos,
              onChanged: (double value) {
                setState(() {
                  yPositionValue2 = value;
                });
              },
            ),
            Text(
              yPositionValue2.round().toString(),
              style: themeData.textTheme.bodyText1,
            ),
          ],
        )
      ],
    );
  }
  // Ending closer for page
}
