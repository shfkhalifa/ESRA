import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../models/child.dart';
import '../../styles.dart';
import 'childChart.dart';
import 'style.dart';
import 'package:fl_chart/fl_chart.dart';

class ChildDetails extends StatefulWidget {
  final Child child;
  const ChildDetails({Key key, this.child}) : super(key: key);

  @override
  _ChildDetailsState createState() => _ChildDetailsState();
}

class _ChildDetailsState extends State<ChildDetails> {
  String _capitalizeName(String str) {
    return '${str[0].toUpperCase()}${str.substring(1)}';
  }

  List<bool> _selections;
  @override
  void initState() {
    super.initState();
    _selections = [true, false, false];
  }

  @override
  Widget build(BuildContext context) {
    double _getBondingMeasure() {
      int bonded = widget.child.predictions
          .where((e) => e.assessAvailable == 'true')
          .length;
      double percent = bonded / (widget.child.predictions.length);

      return percent;
    }

    double _getHasStoryMeasure() {
      int bonded =
          widget.child.predictions.where((e) => e.hasStory == 'Yes').length;
      double percent = bonded / (widget.child.predictions.length);

      return percent;
    }

    double _getChildInPhotoMeasure() {
      int bonded = widget.child.predictions
          .where((e) => e.isChildInPhoto == 'Yes')
          .length;
      double percent = bonded / (widget.child.predictions.length);
      return percent;
    }

    double _getFeelingSadMeasure() {
      int bonded =
          widget.child.predictions.where((e) => e.feeling == 'Sad').length;
      double percent = bonded / (widget.child.predictions.length);
      return percent;
    }

    Widget _getStatCard(String title, subtitle, double value) {
      print('value $value');
      return Card(
        child: Parent(
          style: ParentStyle()
            ..width(MediaQuery.of(context).size.width)
            ..height(120)
            ..padding(all: 10),
          //..padding(vertical: 24, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  text: title,
                  children: <TextSpan>[
                    TextSpan(
                        text: subtitle,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    //centerSpaceRadius: 20,
                    sections: [
                      PieChartSectionData(
                          title: 'Yes',
                          titleStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          value: value,
                          color: Colors.lightGreen,
                          radius: 50),
                      PieChartSectionData(
                          //title: 'No',
                          showTitle: false,
                          value: 100 - value,
                          color: Colors.orangeAccent,
                          radius: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _getStatCard3(
        String title, subtitle, double value1, double value2, double value3) {
      return Card(
        child: Parent(
          style: ParentStyle()
            ..width(MediaQuery.of(context).size.width)
            ..height(120)
            ..padding(all: 10),
          //..padding(vertical: 24, horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  text: title,
                  children: <TextSpan>[
                    TextSpan(
                        text: subtitle,
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .4,
                child: PieChart(
                  PieChartData(
                    borderData: FlBorderData(show: false),
                    //centerSpaceRadius: 20,
                    sections: [
                      PieChartSectionData(
                          title: 'Sad',
                          titleStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          value: value1,
                          color: Colors.red,
                          radius: 48),
                      PieChartSectionData(
                          titleStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          title: 'Happy',
                          showTitle: true,
                          value: value2,
                          color: Colors.green,
                          radius: 50),
                      PieChartSectionData(
                          titleStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                          title: 'Neutral',
                          showTitle: false,
                          value: value3,
                          color: Colors.orangeAccent,
                          radius: 48),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_capitalizeName(widget.child.name)),
        backgroundColor: AppStyles.darkBlue,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Parent(
              style: ChildDetailsStyle.headerStyle,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Image(
                      image: AssetImage(AppIcons.year),
                      width: 30,
                    ),
                    title: Text(
                      _capitalizeName(widget.child.name) +
                          "'s emotions over time",
                      style: Theme.of(context).textTheme.subhead,
                    ),
                  ),

                  ///
                  /// Range picker
                  ///
                  Parent(
                    style: ParentStyle()
                      ..width(MediaQuery.of(context).size.width - 32)
                      ..alignment.center(),
                    child: ToggleButtons(
                      selectedBorderColor: AppStyles.blue,
                      constraints: BoxConstraints(
                          maxHeight: 32,
                          minHeight: 32,
                          minWidth:
                              (MediaQuery.of(context).size.width - 42) / 3),
                      color: AppStyles.lightBlue,
                      selectedColor: Colors.white,
                      fillColor: AppStyles.blue,
                      borderColor: AppStyles.blue,
                      children: <Widget>[
                        Text("WEEKLY"),
                        Text("MONTHLY"),
                        Text("YEARLY"),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < _selections.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              _selections[buttonIndex] = true;
                            } else {
                              _selections[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: _selections,
                    ),
                  ),

                  ///
                  /// Chart
                  ///

                  /// we have no data

                  /// we have data
                  widget.child.predictions.length > 0
                      ? ChildChart(
                          data: widget.child.predictions,
                          period: _selections.indexOf(true),
                        )
                      : Parent(
                          style: ParentStyle()
                            ..alignment.center()
                            ..alignmentContent.center()
                            ..margin(vertical: 14)
                            ..border(all: 1, color: AppStyles.blue)
                            // ..background.color(AppStyles.dimedBlue)
                            ..height(MediaQuery.of(context).size.width * .7)
                            ..width(MediaQuery.of(context).size.width * .7),
                          child: Txt(
                            "No data to show!",
                            style: TxtStyle()
                              ..textColor(AppStyles.lightBlue)
                              ..margin(all: 8)
                              ..textAlign.center(),
                          ),
                        ),

                  ///
                  /// FAQ - Support
                  ///
                  // Divider(color: AppStyles.lightBlue),
                  if (widget.child.predictions.length > 0)
                    // ListTile(
                    //     leading: Icon(Icons.assessment),
                    //     title: Text(
                    //       'You and ${widget.child.name} talked about her drawings ' +
                    //           (_getBondingMeasure() * 100).floor().toString() +
                    //           '% of the time',
                    //       style: Theme.of(context).textTheme.body2,
                    //     )),
                    _getStatCard(
                        'Bonding Measure\n',
                        'Did you talk about the drawings?\n',
                        _getBondingMeasure() * 100),
                  if (widget.child.predictions.length > 0)
                    _getStatCard(
                        'Story of Drawings\n',
                        'Did the drawing have a story?\n',
                        _getHasStoryMeasure() * 100),
                  if (widget.child.predictions.length > 0)
                    _getStatCard(
                        'Drawing Self\n',
                        'Was ${widget.child.name} in the drawing?\n',
                        _getChildInPhotoMeasure() * 100),
                  if (widget.child.predictions.length > 0)
                    _getStatCard3(
                        'Feelings\n', 'How did child feel?\n', 40, 50, 10),

                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/FAQ');
                    },
                    leading: Image(
                      image: AssetImage(AppIcons.info),
                      width: 24,
                    ),
                    title: Text(
                      "Help and Support",
                      //style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                        "Tap here to access our FAQ and get more insights"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
