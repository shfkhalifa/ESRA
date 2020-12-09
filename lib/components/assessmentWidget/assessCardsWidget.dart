import 'package:esra/components/assessmentWidget/customRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:esra/models/assessment.dart';

class AssessmentCardsWidget extends StatefulWidget {
  final Function(AssessmentRecord) onSubmitted;
  const AssessmentCardsWidget({Key key, @required this.onSubmitted})
      : super(key: key);

  @override
  _AssessmentCardsWidgetState createState() => _AssessmentCardsWidgetState();
}

class _AssessmentCardsWidgetState extends State<AssessmentCardsWidget> {
  AssessmentRecord _assessmentRecord = new AssessmentRecord();
  int _index = 0;

  List<String> questionsList = [
    'Are you in this drawing?',
    'Is there a story to the picture?',
    'What were you feeling when drawing the picture?',
  ];

  @override
  Widget build(BuildContext context) {
    List answerList = [
      customRadioButton2(['Yes', 'No'], ['Yes', 'No'],
          storeValue: (value) => setState(() {
                _assessmentRecord.isChildInPhoto = value;
              })),
      customRadioButton2(['Yes', 'No'], ['Yes', 'No'],
          storeValue: (value) => setState(() {
                _assessmentRecord.hasStory = value;
              })),
      customRadioButton2(
          ['Happy', 'Neutral', 'Sad'], ['Happy', 'Neutral', 'Sad'],
          storeValue: (value) => setState(() {
                _assessmentRecord.feeling = value;
              })),
    ];
    return SizedBox(
      height: 600, // card height
      child: PageView.builder(
        itemCount: questionsList.length,
        controller: PageController(viewportFraction: 0.8),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return Transform.scale(
            scale: i == _index ? 1 : 0.9,
            child: Column(
              children: <Widget>[
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          questionsList[i],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: answerList[i],
                      ),
                    ],
                  ),
                ),
                if (_index == questionsList.length - 1)
                  FlatButton(
                    child: Text('Next'),
                    onPressed: () {
                      widget.onSubmitted(_assessmentRecord);
                    },
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
