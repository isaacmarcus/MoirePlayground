import 'package:flutter/material.dart';
import 'package:moire_app/widgets/test_box_number.dart';
import 'package:moire_app/widgets/test_slider.dart';

class TestPage extends StatefulWidget {
  static const id = "test_page";

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  List testBoxList = [];
  List testSlideList = [];
  List testParamList = [];

  void updateFunc(ind, newVal) {
    setState(() {
      testParamList[ind] = newVal;
    });
  }

  void addSlider() {
    setState(() {
      double slideValue = 0;
      testParamList.add(slideValue);
      int boxIndex = testParamList.length - 1;

      testBoxList.add(TestBoxNumber(
        numberDisplay: testParamList,
        boxIndex: boxIndex,
      ));
      testSlideList.add(TestSlider(
        testValue: testParamList,
        updateFunc: updateFunc,
        boxIndex: boxIndex,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addSlider();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: [
            Text("Test Page"),
            // Builder for viewers
            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: ClampingScrollPhysics(),
            //   itemCount: testBoxList.length,
            //   itemBuilder: (BuildContext ctx, int index) {
            //     return testBoxList[index];
            //     // return Text(testParamList[index].toString());
            //     // return TestBoxNumber(
            //     //     numberDisplay: testParamList, boxIndex: index);
            //   },
            // ),
            _buildBoxes(),
            // Builder for sliders
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: testSlideList.length,
              itemBuilder: (BuildContext ctx, int index) {
                return testSlideList[index];
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxes() {
    List<Widget> boxList = [];
    for (int i = 0; i < testBoxList.length; i++) {
      // boxList.add(testBoxList[i]);
      boxList.add(TestBoxNumber(
        numberDisplay: testParamList,
        boxIndex: i,
      ));
    }
    return Column(
      children: boxList,
    );
  }
}
