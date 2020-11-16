// To parse this JSON data, do
//final children = childrenFromJson(jsonString);

import 'dart:convert';

import 'package:esra/models/prediction.dart';

Child childrenFromJson(String str) => Child.fromJson(json.decode(str));

String childrenToJson(Child data) => json.encode(data.toJson());

class Child {
  String id;
  String name;
  int age;
  String gender;
  String parentId;
  List<Prediction> predictions;

  Child({
    this.id,
    this.name,
    this.age,
    this.gender,
    this.parentId,
    this.predictions,
  });

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        id: json["_id"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        parentId: json["parentId"],
        predictions: json["predictions"] == null
            ? null
            : List<Prediction>.from(json["predictions"].map((x) => Prediction.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "age": age,
        "gender": gender,
        "parentId": parentId,
        // "predictions": predictions,
        "predictions": List<dynamic>.from(predictions.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return """Child({
      _id: $id,
      name: $name,
      age: $age,
      gender: $gender,
      prentId: $parentId,
      predictions: $predictions,
      })""";
  }
}
