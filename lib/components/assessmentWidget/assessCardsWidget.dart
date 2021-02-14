import 'package:esra/components/assessmentWidget/customRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:esra/models/assessment.dart';

enum questionType { parent, child }

class AssessmentQuestion {
  String question;
  questionType type;

  AssessmentQuestion(this.question, this.type);
}

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

  List<AssessmentQuestion> questionsList = [
    // child questions
    new AssessmentQuestion('Are you in this drawing?', questionType.child),
    new AssessmentQuestion(
        'Is there a story to the picture?', questionType.child),
    new AssessmentQuestion(
        'How were you feeling while drawing the picture?', questionType.child),
    // Parent questions
    new AssessmentQuestion('Was the image drawn as Instructed or spontaneously',
        questionType.parent),
    new AssessmentQuestion(
        'Was the image drawn in a group or individually', questionType.parent),
    new AssessmentQuestion(
        'Was the image drawn: Before School/After School', questionType.parent),
  ];

  @override
  Widget build(BuildContext context) {
    List answerList = [
      customRadioButton2(
          ['Yes', 'No'], ['Yes', 'No'], _assessmentRecord.isChildInPhoto,
          storeValue: (value) => setState(() {
                _assessmentRecord.isChildInPhoto = value;
              })),
      customRadioButton2(
          ['Yes', 'No'], ['Yes', 'No'], _assessmentRecord.hasStory,
          storeValue: (value) => setState(() {
                _assessmentRecord.hasStory = value;
              })),
      customRadioButton2(['Happy', 'Neutral', 'Sad'],
          ['Happy', 'Neutral', 'Sad'], _assessmentRecord.feeling,
          storeValue: (value) => setState(() {
                _assessmentRecord.feeling = value;
              })),

      //parent choices
      customRadioButton2(['Spontaneous', 'Instructed'], ['Yes', 'No'],
          _assessmentRecord.isSpontaneous, //isSpontaneous
          storeValue: (value) => setState(() {
                _assessmentRecord.isSpontaneous = value;
              })),
      customRadioButton2(['In a group', 'Individual'], ['Yes', 'No'],
          _assessmentRecord.isInGroup, //isInGroup
          storeValue: (value) => setState(() {
                _assessmentRecord.isInGroup = value;
              })),
      customRadioButton2(['Before School', 'After School'], ['Yes', 'No'],
          _assessmentRecord.isBeforeSchool, //isBeforeSchool
          storeValue: (value) => setState(() {
                _assessmentRecord.isBeforeSchool = value;
              })),
    ];
    return SizedBox(
      height: 500, // card height
      child: PageView.builder(
        itemCount: questionsList.length,
        controller: PageController(viewportFraction: 0.75),
        onPageChanged: (int index) => setState(() => _index = index),
        itemBuilder: (_, i) {
          return Transform.scale(
            scale: i == _index ? 1 : 0.9,
            child: Column(
              children: <Widget>[
                new Container(
                  color: questionsList[i].type == questionType.child
                      ? Colors.cyan
                      : Colors.blueGrey,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Text(
                    questionsList[i].type == questionType.child
                        ? "Ask your child"
                        : 'Ask yourself',
                    style: new TextStyle(color: Colors.white),
                  ),
                ),
                Card(
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          questionsList[i].question,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: answerList[i],
                      ),
                    ],
                  ),
                ),
                if (_index == questionsList.length - 1)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: FlatButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Text('Submit'),
                      onPressed: () {
                        widget.onSubmitted(_assessmentRecord);
                      },
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
