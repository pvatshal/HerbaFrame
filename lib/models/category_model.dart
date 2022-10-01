// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.message,
    required this.data,
  });

  dynamic message;
  List<Datum> data;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.categoryId,
    this.no,
    this.name,
  });

  dynamic categoryId;
  dynamic no;
  dynamic name;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    categoryId: json["category_id"],
    no: json["no"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "no": no,
    "name": name,
  };
}
