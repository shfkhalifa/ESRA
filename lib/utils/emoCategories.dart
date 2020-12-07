import 'package:flutter/material.dart';
import 'package:esra/styles.dart';
import 'package:esra/utils/constants.dart';

class EmoCategories {
  Icon getEmoIcon(String label, double score) {
    Icon emoIcon = Icon(Icons.sentiment_neutral);
    print(
        '\n\n inside getEmoIcon got the following label and score $label, $score');
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

  String getEmoLabel(String label, double score) {
    String emoLabel = "Undefined";
    if (label == "negative") {
      if (score > 90) //Highly negative
        emoLabel = Strings.HIGHLY_NEGATIVE_LABEL;
      else if (score > 70) //negative
        emoLabel = Strings.NEGATIVE_LABEL;
      else if (score > 50) // slightly negative
        emoLabel = Strings.SLIGHTLY_NEGATIVE_LABEL;
    } else if (label == "positive") {
      if (score > 90) //Highly negative
        emoLabel = Strings.HIGHLY_POSITIVE_LABEL;
      else if (score > 70) //negative
        emoLabel = Strings.POSITIVE_LABEL;
      else if (score > 50) // slightly negative
        emoLabel = Strings.SLIGHTLY_POSITIVE_LABEL;
    }
    return emoLabel;
  }
}
