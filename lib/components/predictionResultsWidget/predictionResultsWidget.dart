import 'dart:io';

import 'package:division/division.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';

class PredictionResultWidget extends StatelessWidget {
  final String label;
  final double score;
  final File image;
  final Function(bool) onDismiss;
  PredictionResultWidget(
      {Key key, this.label, this.score, this.image, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Parent(
        style: ParentStyle()..margin(all: 14),
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (image != null)
              //   Parent(
              //     style: ParentStyle()
              //       ..background.image(path: image.path, fit: BoxFit.cover)
              //       ..height(200),
              //     child: Container(),
              //   ),

              if (image == null)
                CircleAvatar(
                  radius: 100.0,
                  backgroundColor: Color(0xffffffff),
                )
              else
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage: FileImage(image), // storageImage
                ),

              Parent(
                style: ParentStyle()..margin(vertical: 14),
                child: ListTile(
                  leading: label == "negative"
                      ? Icon(
                          Icons.sentiment_dissatisfied,
                          color: Colors.red,
                          size: 32,
                        )
                      : Icon(
                          Icons.sentiment_satisfied,
                          color: Colors.green,
                          size: 32,
                        ),
                  title: Txt(
                    label == "positive"
                        ? Strings.POSITIVE_LABEL
                        : Strings.NEGATIVE_LABEL,
                    style: TxtStyle()
                      ..textColor(
                          label == "negative" ? Colors.red : Colors.green),
                  ),
                  subtitle: Text(Strings.getLabelDetailText(label, score)),
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    textColor: Colors.red,
                    child: const Text(Strings.DISMISS_BTN_LABEL),
                    onPressed: () {
                      // Dismiss the current prediction
                      onDismiss(false);
                    },
                  ),
                  FlatButton(
                    child: const Text(Strings.SAVE_BTN_LABEL),
                    onPressed: () {
                      onDismiss(true);
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
