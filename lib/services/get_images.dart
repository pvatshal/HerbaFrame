import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/models/images.dart';

import '../constants/.env.dart';


class GetImagesService{
  static Future<Images?> getAllImages() async{
    try{
      Uri url = Uri.parse(domainName+"get_all_images.php");
      Map<String, String> body1 = {
        'tokenKey': tokenKey,
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){

        print(r.body);
        final Images getProfile = imagesFromJson(r.body);
        return getProfile;
      }
    }catch(e){
      print(e);

    }
  }
}