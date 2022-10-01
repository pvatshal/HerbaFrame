import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/models/check_mail_model.dart';
import 'package:image_editor_tutorial/my_screens/business_details.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';

import '../constants/names.dart';
import '../services/check_email_service.dart';
import 'home.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {



  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  bool pass1=false;

  bool isLoading = false;

  void checkMail(String email,String password, String phone, String name){
    setState(() {
      isLoading = true;
    });

    CheckEMailService.getAllCategory(emailController.text).then((value) {
      if(value!=null){

        setState(() {
          if(value.status=="1"){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("User Already Exist"),
              ),
            );
          }else if(value.status=="0"){
            Navigator.push(context, MaterialPageRoute(builder: (
                context) => BusinessDetailsScreen(
              email: emailController.text,
              name: nameController.text,
              phone: phoneController.text,
              password: passwordController.text,)));
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("technical Error"),
              ),
            );
          }

          isLoading = false;

        });

      }
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
              Column(
                children: [
                  Container(
                    width: width,
                    alignment: Alignment.topCenter,
                    height: height*0.05,
                  ),
                  Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: height*0.2,
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
                          child: Text(sign_up_text,style:  GoogleFonts.poppins(
                              color: RoyalOrange,
                              fontSize: 36,
                              fontWeight: FontWeight.w600),),
                        ),
                        Container(
                          height: height*0.06,
                          child: Text(sign_up_tag,style:  GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),),
                        ),
                      ],
                    ),

                  ),
                  Container(
                    width: width,
                    height: height*0.43,
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
                                  child: Text(name_text,style:  GoogleFonts.poppins(
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
                                  child: Text(email_text,style:  GoogleFonts.poppins(
                                      color: RoyalOrange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),),
                                ),
                                Container(
                                  child: TextFormField(

                                    controller: emailController,
                                    decoration: InputDecoration(

                                      filled: true,
                                      fillColor: LightOrange,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Email",
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
                                  child: Text(phone_text,style:  GoogleFonts.poppins(
                                      color: RoyalOrange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),),
                                ),
                                Container(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: LightOrange,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Phone Number",
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
                            height: height*0.13,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height*0.03,
                                  alignment: Alignment.bottomLeft,
                                  child: Text(password_text,style:  GoogleFonts.poppins(
                                      color: RoyalOrange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),),
                                ),
                                Container(
                                  child: TextFormField(
                                    obscureText: !pass1,
                                    controller: passwordController,
                                    decoration: InputDecoration(
                                      suffixIcon:
                                      IconButton(
                                        icon: Icon(
                                          // Based on passwordVisible state choose the icon
                                          pass1
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.black,size: 20,
                                        ),
                                        onPressed: () {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          setState(() {
                                            pass1 = !pass1;
                                          });
                                        },
                                      ),
                                      filled: true,
                                      fillColor: LightOrange,
                                      border: OutlineInputBorder(),
                                      hintText: "Enter Your Password",
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
                                Container(
                                  height: height*0.03,
                                  alignment: Alignment.topRight,
                                  child: Text(forgot_password_text,style:  GoogleFonts.poppins(
                                      color: RoyalOrange,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),),
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

                      if(nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter the Name'),
                          ),
                        );

                      }else if(emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter the Email'),
                          ),
                        );
                      }else if(phoneController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter the Phone'),
                          ),
                        );

                      }else if(phoneController.text.length!=10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Phone number should be 10 digits'),
                          ),
                        );
                      }else if(passwordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Enter the Password'),
                          ),
                        );
                      }else if(passwordController.text.length<=8) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Password should be more than 8 character'),
                          ),
                        );
                      }
                      else{

                        checkMail(emailController.text,passwordController.text,phoneController.text,nameController.text);




                      }
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
                    alignment: Alignment.topCenter,
                    height: height*0.17,
                    padding: EdgeInsets.symmetric(vertical: 10),

                    child:
                    isLoading==true?
                    CircularProgressIndicator(color: RoyalOrange,):Container(),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
