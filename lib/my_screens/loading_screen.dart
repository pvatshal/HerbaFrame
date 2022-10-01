import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/home.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_editor_tutorial/services/get_profile_info_by_email.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/.env.dart';
import '../constants/names.dart';
import '../services/register_service.dart';

class LoadingScreen extends StatefulWidget {

  final String name;
  final String email;
  final String phone;
  final String password;

  final String businessName;
  final String businessEmail;
  final String businessPhone;
  final String businessAddress;
  final String businessTagLine;
  final String instagram;
  final String facebook;
  final String whatsapp;
  final File image;

  const LoadingScreen({Key? key,required this.name,required this.email,required this.phone,
    required this.password,required this.businessName,required this.businessEmail,required this.businessPhone,
    required this.businessAddress,required this.businessTagLine,required this.instagram,required this.facebook,
    required this.whatsapp,required this.image}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  bool isLoading1 = true;
  bool isLoading2 = true;
  bool isLoading3 = true;

  uploadData(){
    RegisterService.addDetailsImages(widget.name, widget.email, widget.phone, widget.password, widget.businessAddress,
        widget.businessName, widget.businessEmail, widget.businessPhone, widget.businessTagLine, widget.instagram,
        widget.facebook, widget.whatsapp,
        "tulsivivahbureau.online/post/logo_images/"+
        widget.email+""+widget.phone+""+widget.businessEmail+".jpg"
    ).then((value) {
          print(value);
          if(value!=null){
            if(value.message=='1'){
              setState(() {
                print("Done");
                getData();
                isLoading2 = false;
              });
            }

          }
    });
  }


  getData()async{

    final prefs = await SharedPreferences.getInstance();

    GetProfileInfoervice.loginInfo(widget.email).then((value) {
      if(value!=null){
        if(value.message=="1"){

          setState(() {
            prefs.setString("user_id", value.userId);
            prefs.setString("name", value.name);
            prefs.setString("email", value.email);
            prefs.setString("phone", value.phone);
            prefs.setString("business_address", value.businessAddress);
            prefs.setString("logo_image", value.logoImage);
            prefs.setString("business_name", value.businessName);
            prefs.setString("business_email", value.businessEmail);
            prefs.setString("is_instagram", value.isInstagram);
            prefs.setString("is_facebook", value.isFacebook);
            prefs.setString("is_whatsapp", value.isWhatsapp);
            prefs.setString("business_phone", value.businessPhone);
            prefs.setString("business_tag_line", value.businessTagLine);
            prefs.setString("screen", "HomeScreen");
            isLoading3 = false;
          });

          // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));

        }
      }

    });


  }


  Future uploadImage() async{
    final uri =  Uri.parse(domainName+"upload_logo.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['tokenKey'] = tokenKey;
    request.fields['name'] = widget.email+""+widget.phone+""+widget.businessEmail;
    var pic = await http.MultipartFile.fromPath("image",widget.image.path);
    request.files.add(pic);

    var response= await request.send();
    if(response.statusCode==200){
      print(response.stream);
      print("image uploaded");
      setState(() {
        isLoading1 =false;
      });
      return 1;
    }else{
      print("image not uploaded");
      return 0;

    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uploadImage();
    uploadData();
  }


  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [

            Container(
              height: height*0.5,
              width: width,
              child: Lottie.asset("graphic_res/animation1.json"),
            ),
            Container(
              decoration: BoxDecoration(
                color: FavYellow,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: FavBlue,width: 3),
                boxShadow: [
                  BoxShadow(
                    color: FavBlue,
                    blurRadius: 5,

                  )
                ]
              ),
              margin: EdgeInsets.symmetric(horizontal: 40),
              height: height*0.18,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    height: height*0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Uploading Personal Details...   ",style: GoogleFonts.poppins(
                            color:  Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                        isLoading2==false?
                        Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.green,):
                            Container()
                      ],
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    height: height*0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Uploading Business Details...   ",style: GoogleFonts.poppins(
                            color:  Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                        isLoading3==false?
                        Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.green,):
                            Container()
                      ],
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.center,
                    height: height*0.05,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Uploading Logo...   ",style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),),
                        isLoading1==false?
                        Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.green,):
                        Container()
                      ],
                    ),

                  ),
                ],
              ),
            ),
            Container(
              height: height*0.3,
              alignment: Alignment.bottomCenter,
              child:
             ( isLoading3==false && isLoading2==false) ?
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePageScreen()));
                },
                  child: Container(

                  alignment: Alignment.center,
                  width: width,
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                  height: height*0.07,
                  decoration: BoxDecoration(
                      color: RoyalOrange,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: RoyalBlue,width: 2)
                  ),
                  child: Text(next,style:  GoogleFonts.poppins(
                      color: RoyalBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),),
                ),
              )
              :
                 Container()
              ,
            )
          ],
        ),
      ),
    );
  }
}
