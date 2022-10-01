// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.message,
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.businessAddress,
    this.logoImage,
    this.businessName,
    this.businessEmail,
    this.isInstagram,
    this.isFacebook,
    this.isWhatsapp,
    this.businessPhone,
    this.businessTagLine,
  });

  dynamic message;
  dynamic userId;
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic businessAddress;
  dynamic logoImage;
  dynamic businessName;
  dynamic businessEmail;
  dynamic isInstagram;
  dynamic isFacebook;
  dynamic isWhatsapp;
  dynamic businessPhone;
  dynamic businessTagLine;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["message"],
    userId: json["user_id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    businessAddress: json["business_address"],
    logoImage: json["logo_image"],
    businessName: json["business_name"],
    businessEmail: json["business_email"],
    isInstagram: json["is_instagram"],
    isFacebook: json["is_facebook"],
    isWhatsapp: json["is_whatsapp"],
    businessPhone: json["business_phone"],
    businessTagLine: json["business_tag_line"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user_id": userId,
    "name": name,
    "email": email,
    "phone": phone,
    "business_address": businessAddress,
    "logo_image": logoImage,
    "business_name": businessName,
    "business_email": businessEmail,
    "is_instagram": isInstagram,
    "is_facebook": isFacebook,
    "is_whatsapp": isWhatsapp,
    "business_phone": businessPhone,
    "business_tag_line": businessTagLine,
  };
}
