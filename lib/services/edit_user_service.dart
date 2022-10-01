import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/models/edit_user_model.dart';
import 'package:image_editor_tutorial/models/images.dart';
import 'package:image_editor_tutorial/models/post_model.dart';

import '../constants/.env.dart';


class EditProfileService{
  static Future<EditUser?> editprofile(String user_id,String name,String business_address,
      String business_name, String business_email,String business_tag_line,String business_phone) async{
    try{
      Uri url = Uri.parse(domainName+"edit_profile.php");
      Map<String, String> body1 = {
        'tokenKey': tokenKey,
        'userid' : user_id,
        'name': name,
        'business_address': business_address,
        'business_name': business_name,
        'business_email': business_email,
        'business_phone': business_phone,
        'business_tag_line': business_tag_line,
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){

        print(r.body);
        final EditUser getProfile = editUserFromJson(r.body);
        return getProfile;
      }
    }catch(e){

    }
  }
}