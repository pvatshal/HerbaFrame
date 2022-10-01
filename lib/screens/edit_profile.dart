
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/my_screens/home.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/names.dart';
import '../constants/styles.dart';
import '../services/edit_user_service.dart';

class EditProfileScreen extends StatefulWidget {
  final String userId;
  final String name;
  final String businessName;
  final String businessEmail;
  final String businessPhone;
  final String businessTagline;
  final String businessAddress;


  const EditProfileScreen({Key? key,required this.name
    ,required this.businessName,
    required this.businessEmail,
    required this.businessPhone,
    required this.businessTagline,required this.businessAddress,required this.userId}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {


  final _formKey = GlobalKey<FormState>();
  bool is_instagram=true;
  bool is_facebook=true;
  bool is_whatsapp=true;
  TextEditingController nameController = TextEditingController();
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



  bool isLoading = false;


  Future<void> update() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });

    EditProfileService.editprofile(widget.userId,nameController.text, businessAddressController.text,
        businessNameController.text, businessEmailController.text,
        businessTaglineController.text,businessPhoneController.text).then((value) {
      if(value!=null){

          if(value.message=="1"){
            isLoading =  false;


            prefs.setString("name", nameController.text);
            prefs.setString("business_address", businessAddressController.text);
            prefs.setString("business_name", businessNameController.text);
            prefs.setString("business_email", businessEmailController.text);
            prefs.setString("business_phone", businessPhoneController.text);
            prefs.setString("business_tag_line",  businessTaglineController.text);


            Timer(
                Duration(seconds: 1),
                    () =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => HomePageScreen())));
          }else{
            isLoading =  false;
          }
      }
    });

  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.name;
    businessNameController.text = widget.businessName;
    businessPhoneController.text = widget.businessPhone;
    businessTaglineController.text = widget.businessTagline;
    businessAddressController.text =  widget.businessAddress;
    businessEmailController.text = widget.businessEmail;
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
                                    child: Text("Your Name",style:  GoogleFonts.poppins(
                                        color: RoyalOrange,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),),
                                  ),
                                  Container(
                                    child: TextFormField(

                                      controller: nameController,
                                      decoration: InputDecoration(

                                        filled: true,
                                        fillColor: LightOrange,
                                        border: OutlineInputBorder(),
                                        hintText: "Enter Your Name",
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


                          ],
                        ),
                      ),
                    ),




                    Container(
                      alignment: Alignment.bottomCenter,
                      height: height*0.1,
                      child:

                      isLoading == true?
                          CircularProgressIndicator(color: RoyalOrange,):

                      InkWell(
                        onTap: (){



                          if(nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Enter the Your Name'),
                              ),
                            );

                          }else if(businessNameController.text.isEmpty) {
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
                          }
                          else{

                            update();
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoadingScreen
                            //   (name: widget.name,
                            //   email: widget.email,
                            //   phone: widget.phone,
                            //   password: widget.password,
                            //   businessName: businessNameController.text,
                            //   businessEmail: businessEmailController.text,
                            //   businessPhone: businessPhoneController.text,
                            //   businessAddress: businessAddressController.text,
                            //   businessTagLine: businessTaglineController.text,
                            //   instagram:  is_instagram==true ?  '1' : '0',
                            //   facebook: is_facebook==true ?  '1' : '0',
                            //   whatsapp: is_whatsapp==true ?  '1' : '0',
                            //   image: _image!,
                            // )));

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
                          child:  Text("Update",style:  GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),),
                        ),
                      ),
                    ),
                    Container(
                      // padding: EdgeInsets.only(top: 10),
                      // child: CircularProgressIndicator(),
                      alignment: Alignment.topCenter,
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
