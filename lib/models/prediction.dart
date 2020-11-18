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

  Prediction({
    this.id,
    this.label,
    this.score,
    this.imagePath,
    this.date,
  });

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
        id: json["_id"] == null ? null : json['_id'],
        label: json["label"],
        score: json["score"].toDouble(),
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
        date: json['date'] == null ? null : DateTime.parse(json['date']),
      );

  Map<String, dynamic> toJson() =>
      {"label": label, "score": score, "imagePath": imagePath, "date": date};

  @override
  String toString() {
    return """Prediction({
      id: $id,
      label: $label,
      score: $score,
      imagePath: $imagePath,
      date: $date,
    })""";
  }
}
