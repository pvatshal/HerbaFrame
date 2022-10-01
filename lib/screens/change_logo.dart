import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/business_details.dart';
import 'package:image_editor_tutorial/my_screens/loading_screen.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/.env.dart';
import '../constants/names.dart';


class ChangeLogoScreen extends StatefulWidget {




  const ChangeLogoScreen({Key? key,
   }) : super(key: key);

  @override
  _ChangeLogoScreenState createState() => _ChangeLogoScreenState();
}

class _ChangeLogoScreenState extends State<ChangeLogoScreen> {

  final _formKey = GlobalKey<FormState>();

  bool pass1=false;


  var bphone;
  var name;
  var baddress;
  var bemail;
  var bname;
  var logo_image;
  var user_id;

  var phone;
  var email;



  void get_details() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      bphone = (prefs.getString('business_phone') ?? 0);
      name = (prefs.getString('name') ?? 0);
      baddress = (prefs.getString('business_address') ?? 0);
      bemail = (prefs.getString('business_email') ?? 0);
      bname = (prefs.getString('business_name') ?? 0);
      logo_image = (prefs.getString('logo_image') ?? 0);
      user_id = (prefs.getString('user_id') ?? 0);
      phone = (prefs.getString('phone') ?? 0);
      email = (prefs.getString('email') ?? 0);


      print(bphone+"\n");
      print(name+"\n");
      print(logo_image);
      print(baddress+"\n");
      print(bemail+"\n");
      print(bname+"\n");
      print(user_id+"\n");


    });

  }


  File? _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      print(_image!.path);
    });
  }


    bool isLoading1 = false;

  Future uploadImage() async{

    setState(() {
      isLoading1=  true;
    });

    final uri =  Uri.parse(domainName+"upload_logo.php");
    var request = http.MultipartRequest('POST',uri);
    request.fields['tokenKey'] = tokenKey;
    request.fields['name'] = email+""+phone+""+bemail;
    var pic = await http.MultipartFile.fromPath("image",_image!.path);
    request.files.add(pic);

    var response= await request.send();
    if(response.statusCode==200){
      print(response.stream);
      print("image uploaded");

      setState(() {
        isLoading1 =false;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logo Updated'),
          ),
        );
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
    get_details();
  }


  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: Container(
          height: height,
          width: width,
          color: RoyalBlue,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    alignment: Alignment.topCenter,
                    height: height*0.2,
                    child: Opacity(
                        opacity: 0.7,
                        child: Image.asset("graphic_res/up_background.png",fit: BoxFit.fill,width: width,)),
                  ),

                  Container(
                    height: height*0.53,
                  ),

                  Container(
                    alignment: Alignment.bottomCenter,
                    height: height*0.27,
                    child: Opacity(
                        opacity: 0.7,
                        child: Image.asset("graphic_res/down_background.png",fit: BoxFit.fill,width: width,)),

                  )

                ],
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: width,
                      alignment: Alignment.topCenter,
                      height: height*0.05,
                    ),
                    Container(
                      width: width,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      height: height*0.14,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: height*0.04,
                              child: IconButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                icon: Icon(FontAwesomeIcons.arrowLeft),
                                color: Colors.white,
                              )
                          ),
                          Container(
                            child: Text("Change Logo",style:  GoogleFonts.poppins(
                                color: RoyalOrange,
                                fontSize: 36,
                                fontWeight: FontWeight.w600),),
                          ),

                        ],
                      ),

                    ),

                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height*0.1,
                      child:   InkWell(
                        onTap: (){
                          choiceImage();
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDetailsScreen()));
                        },
                        child:Container(
                          alignment: Alignment.center,
                          width: width,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: height*0.07,
                          decoration: BoxDecoration(
                              color: RoyalOrange,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2)
                          ),
                          child:  Text(upload_business_logo,style:  GoogleFonts.poppins(
                              color: RoyalBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),
                    _image==null?
                    Container():
                    Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      // height: height*0.3,
                      child: _image==null ? Text("") : Image.file(_image!),
                    )


                    ,




                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height*0.1,
                      child:   InkWell(
                        onTap: (){



                          if(_image==null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Upload Logo'),
                              ),
                            );
                          }
                          else{


                            uploadImage();
                            // Navigator.push(context, MaterialPageRoute(builder: (
                            //     context) => BusinessDetailsScreen(
                            //   email: emailController.text,
                            //   name: nameController.text,
                            //   phone: phoneController.text,
                            //   password: passwordController.text,)));
                          }
















                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDetailsScreen()));
                        },
                        child:Container(
                          alignment: Alignment.center,
                          width: width*0.5,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: height*0.07,
                          decoration: BoxDecoration(
                              color: RoyalOrange,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2)
                          ),
                          child:  Text("Update",style:  GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height*0.17,
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}