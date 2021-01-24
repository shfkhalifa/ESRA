import 'package:division/division.dart';
import 'package:flutter/material.dart';

import '../../models/child.dart';
import '../../styles.dart';
import 'childChart.dart';
import 'style.dart';

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
                  // Icon(
                  //   Icons.sentiment_satisfied,
                  //   size: 100,
                  //   color: Colors.green,
                  // ),
                  // SizedBox(height: 18),
                  // Txt(
                  //   "${widget.child.name} shows positive emotions",
                  //   style: ChildDetailsStyle.emotionStateInfo,
                  // ),
                  // Divider(color: AppStyles.lightBlue),
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
                  Divider(color: AppStyles.lightBlue),
                  if (widget.child.predictions.length > 0)
                    ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text(
                          'You and ${widget.child.name} talked about her drawings ' +
                              (_getBondingMeasure() * 100).floor().toString() +
                              '% of the time',
                          style: Theme.of(context).textTheme.body2,
                        )),
                  if (widget.child.predictions.length > 0)
                    ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text(
                          '${widget.child.name} said there was a story for her drawings ' +
                              (_getHasStoryMeasure() * 100).floor().toString() +
                              '% of the time',
                          style: Theme.of(context).textTheme.body2,
                        )),
                  if (widget.child.predictions.length > 0)
                    ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text(
                          '${widget.child.name} said she was in the picture ' +
                              (_getChildInPhotoMeasure() * 100)
                                  .floor()
                                  .toString() +
                              '% of the time',
                          style: Theme.of(context).textTheme.body2,
                        )),
                  if (widget.child.predictions.length > 0)
                    ListTile(
                        leading: Icon(Icons.assessment),
                        title: Text(
                          '${widget.child.name} said she felt sad while drawing ' +
                              (_getFeelingSadMeasure() * 100)
                                  .floor()
                                  .toString() +
                              '% of the time',
                          style: Theme.of(context).textTheme.body2,
                        )),

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
