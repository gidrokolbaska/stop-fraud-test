// To parse this JSON data, do
//
//     final blacklistModel = blacklistModelFromMap(jsonString);

import 'dart:convert';

class BlacklistModel {
  BlacklistModel({
    required this.action,
    required this.trigger,
  });

  ModelActionBlackList action;
  TriggerBlackList trigger;

  factory BlacklistModel.fromJson(String str) =>
      BlacklistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BlacklistModel.fromMap(Map<String, dynamic> json) => BlacklistModel(
        action: ModelActionBlackList.fromMap(json["action"]),
        trigger: TriggerBlackList.fromMap(json["trigger"]),
      );

  Map<String, dynamic> toMap() => {
        "action": action.toMap(),
        "trigger": trigger.toMap(),
      };
}

class ModelActionBlackList {
  ModelActionBlackList({
    required this.type,
  });

  String type;

  factory ModelActionBlackList.fromJson(String str) =>
      ModelActionBlackList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelActionBlackList.fromMap(Map<String, dynamic> json) =>
      ModelActionBlackList(
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}

class TriggerBlackList {
  TriggerBlackList({
    required this.urlFilter,
  });

  String urlFilter;

  factory TriggerBlackList.fromJson(String str) =>
      TriggerBlackList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TriggerBlackList.fromMap(Map<String, dynamic> json) =>
      TriggerBlackList(
        urlFilter: json["url-filter"],
      );

  Map<String, dynamic> toMap() => {
        "url-filter": urlFilter,
      };
}
