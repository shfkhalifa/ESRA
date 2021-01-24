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
  String isSpontaneous;
  String isInGroup;
  String isBeforeSchool;

  AssessmentRecord(
      {this.isChildInPhoto,
      this.hasStory,
      this.feeling,
      this.isSpontaneous,
      this.isInGroup,
      this.isBeforeSchool});

  factory AssessmentRecord.fromJson(Map<String, dynamic> json) =>
      AssessmentRecord(
          isChildInPhoto:
              json["_isChildInPhoto"] == null ? null : json['_isChildInPhoto'],
          hasStory: json["hasStory"],
          feeling: json["feeling"],
          isSpontaneous: json['isSpontaneous'],
          isInGroup: json['isInGroup'],
          isBeforeSchool: json['isBeforeSchool']);

  Map<String, dynamic> toJson() => {"hasStory": hasStory, "feeling": feeling};

  @override
  String toString() {
    return """assessment({
      id: $isChildInPhoto,
      label: $hasStory,
      feeling: $feeling,
      isSpontaneous: $isSpontaneous,
      isInGroup: $isInGroup,
      isBeforeSchool: $isBeforeSchool,
    })""";
  }
}
