import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/models/category_model.dart';
import 'package:image_editor_tutorial/models/check_mail_model.dart';
import 'package:image_editor_tutorial/models/images.dart';

import '../constants/.env.dart';
import '../models/login_model.dart';


class GetProfileInfoervice{
  static Future<Login?> loginInfo(String email) async{
    try{
      Uri url = Uri.parse(domainName+"get_info_by_user_id.php");
      Map<String, String> body1 = {
        'tokenKey': tokenKey,
        'email':email,
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){

        print(r.body);
        final Login getProfile = loginFromJson(r.body);
        return getProfile;
      }
    }catch(e){

    }
  }
}