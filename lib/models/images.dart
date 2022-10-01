// To parse this JSON data, do
//
//     final images = imagesFromJson(jsonString);

import 'dart:convert';

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    this.message,
    required this.data,
  });

  dynamic message;
  List<Datum> data;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
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
    this.imageId,
    this.category,
    this.subCategory,
    this.image,
    this.dateOfEvent,
    this.date,
    this.time,
  });

  dynamic imageId;
  dynamic category;
  dynamic subCategory;
  dynamic image;
  dynamic dateOfEvent;
  dynamic date;
  dynamic time;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    imageId: json["image_id"],
    category: json["category"],
    subCategory: json["sub_category"],
    image: json["image"],
    dateOfEvent: json["date_of_event"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "image_id": imageId,
    "category": category,
    "sub_category": subCategory,
    "image": image,
    "date_of_event": dateOfEvent,
    "date": date,
    "time": time,
  };
}
