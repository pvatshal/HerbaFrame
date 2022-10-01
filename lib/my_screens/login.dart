import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_editor_tutorial/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/names.dart';
import 'home.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {



  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool pass1=false;

  bool isLoading = false;

  Future<void> logincheck() async {

    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoading  = true;
    });
    print("1st");

    LoginService.loginInfo(emailController.text, passwordController.text).then((value) {
      if(value!=null){
        setState(() {
          if(value.message=="1"){ // success
            print("2nd");

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

             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePageScreen()));

            isLoading=false;

          }else if(value.message=="0"){ // forgot password
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Incorrect Password'),
              ),
            );
            isLoading=false;

          }else if(value.message=="-1"){ // No user exist Register your self
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User does not exist!'),
              ),
            );
            isLoading=false;

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Technical Error!!'),
              ),
            );
            isLoading=false;

          }



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
          child: Column(
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
                      child: Text(sign_in,style:  GoogleFonts.poppins(
                          color: RoyalOrange,
                          fontSize: 36,
                          fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      height: height*0.06,
                      child: Text(login_tag,style:  GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),

              ),
              Container(
                width: width,
                height: height*0.23,
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
                                  hintText: "Create Your Password",
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

                    if(emailController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter your email'),
                        ),
                      );
                    }else if(passwordController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Enter your password'),
                        ),
                      );
                    }else{
                      logincheck();
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
                    child:  Text(sign_in,style:  GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: height*0.27,
                child: Stack(
                  children: [
                    Opacity(
                        opacity: 0.7,
                        child: Image.asset("graphic_res/down_background.png",fit: BoxFit.fill,width: width,)
                    ),
                    isLoading==true?
                        Container(
                            height: height*0.27,
                            width: width,
                            alignment: Alignment.topCenter,
                            padding: EdgeInsets.only(top: 5),
                            child: CircularProgressIndicator(color: RoyalOrange,))
                        :
                        Container()
                  ],
                ),

              )

            ],
          ),
        ),
      ),
    );
  }
}
