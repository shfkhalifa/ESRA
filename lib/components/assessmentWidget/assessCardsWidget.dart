import 'package:esra/components/assessmentWidget/customRadioButton.dart';
import 'package:esra/localization/language_constants.dart';
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

  List<AssessmentQuestion> questionsList;

  @override
  Widget build(BuildContext context) {
    String yesStr = getTranslated(context, "YES");
    String noStr = getTranslated(context, "NO");
    final questionsList = [
      // child questions
      new AssessmentQuestion(
          getTranslated(context, 'Q_IN_DRAWING'), questionType.child),
      new AssessmentQuestion(
          getTranslated(context, 'Q_STORY'), questionType.child),
      new AssessmentQuestion(
          getTranslated(context, 'Q_FEELING'), questionType.child),
      // Parent questions
      new AssessmentQuestion(
          getTranslated(context, 'Q_INSTRUCTED'), questionType.parent),
      new AssessmentQuestion(
          getTranslated(context, 'Q_IN_GROUP'), questionType.parent),
      new AssessmentQuestion(
          getTranslated(context, 'Q_BEFORE_SCHOOL'), questionType.parent),
    ];
    List answerList = [
      customRadioButton2(
          [yesStr, noStr], [yesStr, noStr], _assessmentRecord.isChildInPhoto,
          storeValue: (value) => setState(() {
                _assessmentRecord.isChildInPhoto = value;
              })),
      customRadioButton2(
          [yesStr, noStr], [yesStr, noStr], _assessmentRecord.hasStory,
          storeValue: (value) => setState(() {
                _assessmentRecord.hasStory = value;
              })),
      customRadioButton2([
        getTranslated(context, "HAPPY"),
        getTranslated(context, "NEUTRAL"),
        getTranslated(context, "SAD")
      ], [
        'Happy',
        'Neutral',
        'Sad'
      ], _assessmentRecord.feeling,
          storeValue: (value) => setState(() {
                _assessmentRecord.feeling = value;
              })),

      //parent choices
      customRadioButton2([
        getTranslated(context, "SPONTANEOUS"),
        getTranslated(context, "INSTRUCTED")
      ], [
        'Yes',
        'No'
      ], _assessmentRecord.isSpontaneous, //isSpontaneous
          storeValue: (value) => setState(() {
                _assessmentRecord.isSpontaneous = value;
              })),
      customRadioButton2([
        getTranslated(context, "IN_GROUP"),
        getTranslated(context, "INDIVIDUAL")
      ], [
        'Yes',
        'No'
      ], _assessmentRecord.isInGroup, //isInGroup
          storeValue: (value) => setState(() {
                _assessmentRecord.isInGroup = value;
              })),
      customRadioButton2([
        getTranslated(context, 'BEFORE_SCHOOL'),
        getTranslated(context, 'AFTER_SCHOOL')
      ], [
        'Yes',
        'No'
      ], _assessmentRecord.isBeforeSchool, //isBeforeSchool
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
                        ? getTranslated(context, "ASK_YOUR_CHILD")
                        : getTranslated(context, "ASK_YOURSELF"),
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
                      child: Text(getTranslated(context, 'SUBMIT_BTN')),
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
