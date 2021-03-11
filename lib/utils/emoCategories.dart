import 'package:flutter/material.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/constants.dart';
import "package:esra/localization/language_constants.dart";

class EmoCategories {
  Icon getEmoIcon(String label, double score) {
    Icon emoIcon = Icon(Icons.sentiment_neutral);
    if (label == "negative") {
      if (score > 90) //Highly negative
        emoIcon = Icon(
          Icons.sentiment_very_dissatisfied,
          color: AppStyles.highNegativeColor,
          size: 32,
        );
      else if (score > 70) //negative
        emoIcon = Icon(
          Icons.sentiment_dissatisfied,
          color: AppStyles.mediumNegativeColor,
          size: 32,
        );
      else if (score > 50) // slightly negative
        emoIcon = Icon(
          Icons.sentiment_neutral,
          color: AppStyles.lowNegativeColor,
          size: 32,
        );
    } else if (label == "positive") {
      //hightly positive
      if (score > 90)
        emoIcon = Icon(
          Icons.sentiment_very_satisfied,
          color: AppStyles.highPositiveColor,
          size: 32,
        );
      else if (score > 70) // positive
        emoIcon = Icon(
          Icons.sentiment_satisfied,
          color: AppStyles.mediumPositiveColor,
          size: 32,
        );
      else if (score > 50) //slightly positive
        emoIcon = Icon(
          Icons.sentiment_neutral,
          color: AppStyles.lowPositiveColor,
          size: 32,
        );
    }

    return emoIcon;
  }

  String getEmoLabel(String label, double score, BuildContext context) {
    String emoLabel = "Undefined";
    if (label == "negative") {
      if (score > 90) //Highly negative
        emoLabel = getTranslated(context, "HIGHLY_NEGATIVE_LABEL");
      else if (score > 70) //negative
        emoLabel = getTranslated(context, 'NEGATIVE_LABEL');
      else if (score > 50) // slightly negative
        emoLabel = getTranslated(context, 'SLIGHTLY_NEGATIVE_LABEL');
    } else if (label == "positive") {
      if (score > 90) //Highly negative
        emoLabel = getTranslated(context, 'HIGHLY_POSITIVE_LABEL');
      else if (score > 70) //negative
        emoLabel = getTranslated(context, 'POSITIVE_LABEL');
      else if (score > 50) // slightly negative
        emoLabel = getTranslated(context, 'SLIGHTLY_POSITIVE_LABEL');
    }
    return emoLabel;
  }

  String getLabelDetailText(String label, double score, BuildContext context) {
    print('\n LABEL received is: $label');
    String stringLabel = label.contains('positive')
        ? getTranslated(context, 'POSITIVE_LABEL')
        : getTranslated(context, 'NEGATIVE_LABEL');
    return getTranslated(context, 'RESULT_TEXT1') +
        ' ${stringLabel.toLowerCase()}' +
        getTranslated(context, 'RESULT_TEXT2') +
        '${(score * 100).round()}%';
  }
}
