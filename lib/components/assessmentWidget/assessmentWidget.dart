import 'package:division/division.dart';
import 'package:esra/components/assessmentWidget/customRadioButton.dart';
import 'package:esra/models/assessment.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:esra/components/assessmentWidget/assessCardsWidget.dart';

enum assessChoice { yes, no }

class AssessmentWidget extends StatefulWidget {
  final Function(AssessmentRecord) onSubmitted;
  const AssessmentWidget({Key key, @required this.onSubmitted})
      : super(key: key);

  @override
  _AssessmentWidgetState createState() => _AssessmentWidgetState();
}

class _AssessmentWidgetState extends State<AssessmentWidget> {
  final TextEditingController _feedbackTextController = TextEditingController();
  //final _assessmentFormKey = GlobalKey<FormState>();
  assessChoice _assessChoice = assessChoice.no;

  @override
  void dispose() {
    super.dispose();
    _feedbackTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Parent(
        style: ParentStyle()..margin(all: 12),
        child: Column(
          children: <Widget>[
            Card(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8),
                    child: ListTile(
                      title: Text(Strings.ASSESSMENT_CARD_TITLE),
                      subtitle: Text(Strings.ASSESSMENT_CARD_SUBTITLE),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 100, bottom: 30, top: 20),
                    child: customRadioButton2(
                        ['Yes', 'No'], [assessChoice.yes, assessChoice.no],
                        storeValue: (value) {
                      setState(() {
                        _assessChoice = value;
                      });
                    }),
                  )
                ],
              ),
            ),
            if (_assessChoice == assessChoice.yes)
              AssessmentCardsWidget(onSubmitted: widget.onSubmitted),
          ],
        ),
      ),
    );
  }
}
