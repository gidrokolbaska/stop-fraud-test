// To parse this JSON data, do
//
//     final whitelistModel = whitelistModelFromMap(jsonString);

import 'dart:convert';

class WhitelistModel {
  WhitelistModel({
    required this.action,
    required this.trigger,
  });

  ModelActionWhiteList action;
  TriggerWhiteList trigger;

  factory WhitelistModel.fromJson(String str) =>
      WhitelistModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WhitelistModel.fromMap(Map<String, dynamic> json) => WhitelistModel(
        action: ModelActionWhiteList.fromMap(json["action"]),
        trigger: TriggerWhiteList.fromMap(json["trigger"]),
      );

  Map<String, dynamic> toMap() => {
        "action": action.toMap(),
        "trigger": trigger.toMap(),
      };
}

class ModelActionWhiteList {
  ModelActionWhiteList({
    required this.type,
  });

  String type;

  factory ModelActionWhiteList.fromJson(String str) =>
      ModelActionWhiteList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ModelActionWhiteList.fromMap(Map<String, dynamic> json) =>
      ModelActionWhiteList(
        type: json["type"],
      );

  Map<String, dynamic> toMap() => {
        "type": type,
      };
}

class TriggerWhiteList {
  TriggerWhiteList({
    required this.urlFilter,
    required this.ifDomain,
  });

  String urlFilter;
  List<String> ifDomain;

  factory TriggerWhiteList.fromJson(String str) =>
      TriggerWhiteList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TriggerWhiteList.fromMap(Map<String, dynamic> json) =>
      TriggerWhiteList(
        urlFilter: json["url-filter"],
        ifDomain: List<String>.from(json["if-domain"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "url-filter": urlFilter,
        "if-domain": List<dynamic>.from(ifDomain.map((x) => x)),
      };
}
