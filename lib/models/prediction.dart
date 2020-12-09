// To parse this JSON data, do
//
//     final prediction = predictionFromJson(jsonString);

import 'dart:convert';

Prediction predictionFromJson(String str) =>
    Prediction.fromJson(json.decode(str));

String predictionToJson(Prediction data) => json.encode(data.toJson());

class Prediction {
  String id;
  String label;
  double score;
  String imagePath;
  DateTime date;
  String feeling;
  String isChildInPhoto;
  String hasStory;

  Prediction(
      {this.id,
      this.label,
      this.score,
      this.imagePath,
      this.date,
      this.feeling,
      this.isChildInPhoto,
      this.hasStory});

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        id: json["_id"] == null ? null : json['_id'],
        label: json["label"],
        score: json["score"].toDouble(),
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
        feeling: json["feeling"],
        isChildInPhoto: json['isChildInPhoto'],
        hasStory: json['hasStory'],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "score": score,
        "imagePath": imagePath,
        "date": date,
        "feeling": feeling,
        "isChildInPhoto": isChildInPhoto,
        "hasStory": hasStory
      };

  @override
  String toString() {
    return """Prediction({
      id: $id,
      label: $label,
      score: $score,
      imagePath: $imagePath,
      date: $date,
      feeling: $feeling
      hasStory: $hasStory
      isChildInPhoto: $isChildInPhoto
    })""";
  }
}
