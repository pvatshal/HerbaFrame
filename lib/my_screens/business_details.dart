import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/business_details.dart';
import 'package:image_editor_tutorial/my_screens/loading_screen.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/names.dart';
import 'home.dart';


class BusinessDetailsScreen extends StatefulWidget {

  final String name;
  final String email;
  final String phone;
  final String password;



  const BusinessDetailsScreen({Key? key,
    required this.name,
    required this.email,
    required this.phone,
    required this.password}) : super(key: key);

  @override
  _BusinessDetailsScreenState createState() => _BusinessDetailsScreenState();
}

class _BusinessDetailsScreenState extends State<BusinessDetailsScreen> {

  final _formKey = GlobalKey<FormState>();
  bool is_instagram=true;
  bool is_facebook=true;
  bool is_whatsapp=true;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessEmailController = TextEditingController();
  TextEditingController businessPhoneController = TextEditingController();
  TextEditingController businessTaglineController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();

  bool pass1=false;



  File? _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
      print(_image!.path);
    });
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
                            child: Text(your_company,style:  GoogleFonts.poppins(
                                color: RoyalOrange,
                                fontSize: 36,
                                fontWeight: FontWeight.w600),),
                          ),

                        ],
                      ),

                    ),
                    Container(
                      width: width,
                      // height: height*0.55,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(business_name_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(

                                      controller: businessNameController,
                                      decoration: InputDecoration(

                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Business Name",
                                        hintStyle: TextStyle(
                                            color: RoyalBlue,
                                            fontSize: 14

                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(business_email_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(

                                      controller: businessEmailController,
                                      decoration: InputDecoration(

                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Business Email",
                                        hintStyle: TextStyle(
                                            color: RoyalBlue,
                                            fontSize: 14

                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(business_phone_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: businessPhoneController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Business Phone Number",
                                        hintStyle: TextStyle(
                                            color: RoyalBlue,
                                            fontSize: 14
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(business_address_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: businessAddressController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Business Address",
                                        hintStyle: TextStyle(
                                            color: RoyalBlue,
                                            fontSize: 14
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(business_tag_line_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(
                                      controller: businessTaglineController,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Business Tag Line",
                                        hintStyle: TextStyle(
                                            color: RoyalBlue,
                                            fontSize: 14
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(color: LightOrange),
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                      ),

                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(insta_handle_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child:  Container(
                                      alignment: Alignment.center,
                                      // color: Colors.blue,
                                      // margin: EdgeInsets.symmetric(horizontal: 18,vertical: 0),
                                      width: width,
                                      height: height*0.06,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_instagram=true;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_instagram==false ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,

                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(0),bottomRight: Radius.circular(0))
                                              ),

                                              child: Text("Yes",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(color: is_instagram==false ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_instagram=false;

                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_instagram==true ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(0),bottomLeft: Radius.circular(0),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                                              ),
                                              child: Text("No",style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(color: is_instagram==true ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                              ),),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(facebook_handle_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child:  Container(
                                      alignment: Alignment.center,
                                      // color: Colors.blue,
                                      // margin: EdgeInsets.symmetric(horizontal: 18,vertical: 0),
                                      width: width,
                                      height: height*0.06,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_facebook=true;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_facebook==false ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,

                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(0),bottomRight: Radius.circular(0))
                                              ),

                                              child: Text("Yes",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(color: is_facebook==false ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_facebook=false;

                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_facebook==true ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(0),bottomLeft: Radius.circular(0),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                                              ),
                                              child: Text("No",style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(color: is_facebook==true ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                              ),),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              width: width,
                              height: height*0.1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    height: height*0.03,
                                    child: Text(whatsapp_handle_text,style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child:  Container(
                                      alignment: Alignment.center,
                                      // color: Colors.blue,
                                      // margin: EdgeInsets.symmetric(horizontal: 18,vertical: 0),
                                      width: width,
                                      height: height*0.06,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_whatsapp=true;
                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_whatsapp==false ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,

                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),topRight: Radius.circular(0),bottomRight: Radius.circular(0))
                                              ),

                                              child: Text("Yes",
                                                style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(color: is_whatsapp==false ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                is_whatsapp=false;

                                              });
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.07,
                                              width: width*0.5-20,
                                              decoration: BoxDecoration(
                                                  color:
                                                  is_whatsapp==true ?
                                                  RoyalBlue :
                                                  RoyalOrange
                                                  ,
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(color: RoyalOrange),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(0),bottomLeft: Radius.circular(0),topRight: Radius.circular(20),bottomRight: Radius.circular(20))
                                              ),
                                              child: Text("No",style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(color: is_whatsapp==true ? RoyalOrange : RoyalBlue ,fontSize: 14,fontWeight: FontWeight.w700)
                                              ),),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),


                                ],
                              ),
                            ),

                          ],
                        ),
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
                    ),




                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height*0.1,
                      child:   InkWell(
                        onTap: (){



                          if(businessNameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Business Name'),
                              ),
                            );

                          }else if(businessEmailController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Business Email'),
                              ),
                            );
                          }else if(businessPhoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Business Phone'),
                              ),
                            );

                          }else if(businessAddressController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Business Address'),
                              ),
                            );
                          }else if(businessTaglineController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Business Tag Line'),
                              ),
                            );
                          }else if(_image==null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Upload Logo'),
                              ),
                            );
                          }
                          else{
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingScreen
                              (name: widget.name,
                                email: widget.email,
                                phone: widget.phone,
                                password: widget.password,
                                businessName: businessNameController.text,
                                businessEmail: businessEmailController.text,
                                businessPhone: businessPhoneController.text,
                                businessAddress: businessAddressController.text,
                                businessTagLine: businessTaglineController.text,
                                instagram:  is_instagram==true ?  '1' : '0',
                                facebook: is_facebook==true ?  '1' : '0',
                                whatsapp: is_whatsapp==true ?  '1' : '0',
                              image: _image!,
                            )));

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
                          width: width,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: height*0.07,
                          decoration: BoxDecoration(
                              color: RoyalOrange,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,width: 2)
                          ),
                          child:  Text(register_text,style:  GoogleFonts.poppins(
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