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
                      width: 24,
                    ),
                    title: Text(
                      _capitalizeName(widget.child.name) +
                          "'s emotions over time",
                      //style: Theme.of(context).textTheme.headline6,
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
