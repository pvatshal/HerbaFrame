import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/login.dart';
import 'package:image_editor_tutorial/my_screens/register.dart';

import '../constants/names.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),

  );
}

class _WelcomeScreenState extends State<WelcomeScreen> {


  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) =>

          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
            backgroundColor: RoyalBlue.withOpacity(0.9),
            title: Text('Exit'),
            content: Text('Do you want to exit an App?',style: TextStyle(color: RoyalOrange,fontSize: 18),),
            actions:[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child:Text('No'),
              ),

              ElevatedButton(
                onPressed: () => exit(0),
                //return true when click on "Yes"
                child:Text('Yes'),
              ),

            ],
          ),
    )??false; //if showDialouge had returned null, then return false
  }


  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(

        body: Container(
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
                      child: Text(welcome,style:  GoogleFonts.poppins(
                          color: RoyalOrange,
                          fontSize: 36,
                          fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: Text(welcome_tag,style:  GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),),
                    ),
                  ],
                ),

              ),
              Container(
                height: height*0.25,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(_createRoute());
                      },
                      child: Container(
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
                    InkWell(
                      onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: width,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: height*0.07,
                        decoration: BoxDecoration(
                            color: RoyalBlue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: RoyalOrange,width: 2)
                        ),
                        child:  Text(create_an_account,style:  GoogleFonts.poppins(
                            color: RoyalOrange,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: height*0.35,
                child: Opacity(
                    opacity: 0.7,
                    child: Image.asset("graphic_res/down_background.png",fit: BoxFit.fill,width: width,)),

              )

            ],
          ),
        ),
      ),
    );
  }
}
