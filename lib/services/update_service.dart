import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/models/images.dart';

import '../constants/.env.dart';
import '../models/update_model.dart';


class UpdateVersionService{
  static Future<Update?> getVersion() async{
    try{
      Uri url = Uri.parse(domainName+"check_update.php");
      Map<String, String> body1 = {
      };
      Response r = await post(
        url,
        body: body1,
      );
      if(r.statusCode==200){
        print(r.body);
        final Update getProfile = updateFromJson(r.body);
        return getProfile;
      }
    }catch(e){

    }
  }
}