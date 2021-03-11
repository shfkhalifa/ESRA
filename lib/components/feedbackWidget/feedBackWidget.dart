import 'package:division/division.dart';
import 'package:esra/localization/language_constants.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';

class FeedbackWidget extends StatefulWidget {
  final Function(String) onSubmit;
  const FeedbackWidget({Key key, @required this.onSubmit}) : super(key: key);

  @override
  _FeedbackWidgetState createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  final TextEditingController _feedbackTextController = TextEditingController();
  final _feedbackFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _feedbackTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Parent(
        style: ParentStyle()..margin(all: 14),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                child: ListTile(
                  title: Text(Strings.FEEDBACK_CARD_TITLE),
                  subtitle: Text(Strings.FEEDBACK_CARD_SUBTITLE),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: Form(
                  key: _feedbackFormKey,
                  child: TextFormField(
                    controller: _feedbackTextController,
                    decoration: InputDecoration(
                        hintText: "Enter your feedback...",
                        border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.done,
                    maxLines: null,
                    maxLength: 500,
                    autocorrect: true,
                    validator: (value) {
                      return value.isEmpty
                          ? Strings.EMPTY_FEEDBACK_ERROR
                          : null;
                    },
                  ),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text(getTranslated(context, "SUBMIT_BTN")),
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      if (_feedbackFormKey.currentState.validate()) {
                        widget.onSubmit(_feedbackTextController.text);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
