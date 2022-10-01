import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/models/category_model.dart';
import 'package:image_editor_tutorial/models/images.dart';

import '../constants/.env.dart';


class GetCategoryService{
  static Future<Category?> getAllCategory() async{
    try{
      Uri url = Uri.parse(domainName+"get_category.php");
      Map<String, String> body1 = {
        'tokenKey': tokenKey,
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){

        print(r.body);
        final Category getProfile = categoryFromJson(r.body);
        return getProfile;
      }
    }catch(e){

    }
  }
}