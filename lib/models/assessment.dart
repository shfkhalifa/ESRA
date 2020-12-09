// To parse this JSON data, do
//
//     final assessment = assessmentFromJson(jsonString);

import 'dart:convert';

AssessmentRecord assessmentFromJson(String str) =>
    AssessmentRecord.fromJson(json.decode(str));

String assessmentToJson(AssessmentRecord data) => json.encode(data.toJson());

class AssessmentRecord {
  String isChildInPhoto;
  String hasStory;
  String feeling;

  AssessmentRecord({
    this.isChildInPhoto,
    this.hasStory,
    this.feeling,
  });

  factory AssessmentRecord.fromJson(Map<String, dynamic> json) =>
      AssessmentRecord(
        isChildInPhoto:
            json["_isChildInPhoto"] == null ? null : json['_isChildInPhoto'],
        hasStory: json["hasStory"],
        feeling: json["feeling"],
      );

  Map<String, dynamic> toJson() => {"hasStory": hasStory, "feeling": feeling};

  @override
  String toString() {
    return """assessment({
      id: $isChildInPhoto,
      label: $hasStory,
      feeling: $feeling,
    })""";
  }
}
