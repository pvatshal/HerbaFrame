// To parse this JSON data, do
//
//     final update = updateFromJson(jsonString);

import 'dart:convert';

Update updateFromJson(String str) => Update.fromJson(json.decode(str));

String updateToJson(Update data) => json.encode(data.toJson());

class Update {
  Update({
    this.message,
    this.update,
  });

  dynamic message;
  dynamic update;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
    message: json["message"],
    update: json["update"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "update": update,
  };
}
