// To parse this JSON data, do
//
//     final clickModel = clickModelFromMap(jsonString);

import 'dart:convert';

ClickModel clickModelFromMap(String str) =>
    ClickModel.fromMap(json.decode(str));

String clickModelToMap(ClickModel data) => json.encode(data.toMap());

class ClickModel {
  ClickModel({
    required this.status,
    required this.description,
  });

  int status;
  String description;

  factory ClickModel.fromMap(Map<String, dynamic> json) => ClickModel(
        status: json["status"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "description": description,
      };
}
