// To parse this JSON data, do
//
//     final editUser = editUserFromJson(jsonString);

import 'dart:convert';

EditUser editUserFromJson(String str) => EditUser.fromJson(json.decode(str));

String editUserToJson(EditUser data) => json.encode(data.toJson());

class EditUser {
  EditUser({
    this.message,
    this.userid,
  });

  dynamic message;
  dynamic userid;

  factory EditUser.fromJson(Map<String, dynamic> json) => EditUser(
    message: json["message"],
    userid: json["userid"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "userid": userid,
  };
}
