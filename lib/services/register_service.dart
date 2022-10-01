import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/models/images.dart';
import 'package:image_editor_tutorial/models/post_model.dart';

import '../constants/.env.dart';


class RegisterService{
  static Future<Post?> addDetailsImages(String name,String email,String phone,String password,String business_address,
      String business_name, String business_email,String business_phone,String business_tag_line,
      String is_instagram,String is_facebook,String is_whatsapp,String logo_image) async{
    try{
      Uri url = Uri.parse(domainName+"register.php");
      Map<String, String> body1 = {
        'tokenKey': tokenKey,
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'business_address': business_address,
        'business_name': business_name,
        'business_email': business_email,
        'business_phone': business_phone,
        'business_tag_line': business_tag_line,
        'is_instagram': is_instagram,
        'is_facebook': is_facebook,
        'is_whatsapp': is_whatsapp,
        'logo_image': logo_image,
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){

        print(r.body);
        final Post getProfile = postFromJson(r.body);
        return getProfile;
      }
    }catch(e){

    }
  }
}