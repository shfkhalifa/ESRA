import 'dart:io';

import 'package:division/division.dart';
import 'package:esra/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:esra/models/prediction.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/emoCategories.dart';
import 'package:path/path.dart' as path;

class ResultReviewPage extends StatelessWidget {
  final Prediction prediction;
  ResultReviewPage({Key key, this.prediction}) : super(key: key);

  Widget textCard(IconData icon, Color iconColor, String text) {
    return Card(
      child: Parent(
        child: ListTile(
          leading: Icon(
            icon,
            size: 30,
            color: iconColor,
          ),
          title: Text(text,
              style: TextStyle(color: Colors.grey[600], fontSize: 15)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('image path is : ${prediction.imagePath}');
    String hmImagePath =
        '${path.dirname(prediction.imagePath)}/hm_${path.basename(prediction.imagePath)}';
    print('heatmap path is: $hmImagePath');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppStyles.darkBlue,
          title: Text(Strings.RESULT_REVIEW_TITLE),
        ),
        body: SingleChildScrollView(
          child: Parent(
            style: ParentStyle()..margin(all: 14),
            child: Column(
              children: <Widget>[
                Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (File(prediction.imagePath) != null)
                        Parent(
                          style: ParentStyle()
                            ..background.image(
                                imageProveder: FileImage(File(hmImagePath)),
                                // imageProveder:
                                //     FileImage(File(prediction.imagePath)),
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
                            EmoCategories().getEmoLabel(
                                prediction.label, prediction.score),
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
                if (prediction.feeling != null)
                  textCard(
                      Icons.face,
                      Colors.cyan,
                      'Your child was feeling ' +
                          prediction.feeling.toLowerCase()),
                if (prediction.hasStory == 'Yes')
                  textCard(Icons.local_library, Colors.cyan,
                      'Your child said this drawing had a story'),
                if (prediction.isChildInPhoto == 'Yes')
                  textCard(Icons.child_care, Colors.cyan,
                      'Your child drew himself/herself in this photo'),
                if (prediction.isSpontaneous != null)
                  textCard(
                      Icons.speaker_notes,
                      Colors.blueGrey,
                      prediction.isSpontaneous == 'Yes'
                          ? 'This was a spontaneous drawing'
                          : 'This was an instructed drawing'),
                if (prediction.isBeforeSchool != null)
                  textCard(
                      Icons.speaker_notes,
                      Colors.blueGrey,
                      prediction.isBeforeSchool == 'Yes'
                          ? 'This was drawn before school'
                          : 'This was drawn after school'),
                if (prediction.isInGroup != null)
                  textCard(
                      Icons.speaker_notes,
                      Colors.blueGrey,
                      prediction.isInGroup == 'Yes'
                          ? 'This was drawn in a group'
                          : 'This was drawn individually'),
              ],
            ),
          ),
        ));
  }
}
