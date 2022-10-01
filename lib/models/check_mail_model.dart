// To parse this JSON data, do
//
//     final checkEMail = checkEMailFromJson(jsonString);

import 'dart:convert';

CheckEMail checkEMailFromJson(String str) => CheckEMail.fromJson(json.decode(str));

String checkEMailToJson(CheckEMail data) => json.encode(data.toJson());

class CheckEMail {
  CheckEMail({
    this.status,
    this.message,
  });

  dynamic status;
  dynamic message;

  factory CheckEMail.fromJson(Map<String, dynamic> json) => CheckEMail(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
