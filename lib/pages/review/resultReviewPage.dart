import 'dart:io';

import 'package:division/division.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:esra/models/prediction.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/emoCategories.dart';

class ResultReviewPage extends StatelessWidget {
  final Prediction prediction;
  ResultReviewPage({Key key, this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(Strings.RESULT_REVIEW_TITLE),
        ),
        body: Container(
          child: Parent(
            style: ParentStyle()..margin(all: 14),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (File(prediction.imagePath) != null)
                    Parent(
                      style: ParentStyle()
                        ..background.image(
                            imageProveder:
                                FileImage(File(prediction.imagePath)),
                            fit: BoxFit.contain)
                        ..height(200),
                      child: Container(),
                    ),
                  Parent(
                    style: ParentStyle()..margin(vertical: 14),
                    child: ListTile(
                      leading: EmoCategories()
                          .getEmoIcon(prediction.label, prediction.score),
                      title: Txt(
                        EmoCategories()
                            .getEmoLabel(prediction.label, prediction.score),
                        style: TxtStyle()
                          ..textColor(prediction.label == "negative"
                              ? Colors.red
                              : Colors.green),
                      ),
                      subtitle: Text(Strings.getLabelDetailText(
                          prediction.label, (prediction.score) / 100)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}