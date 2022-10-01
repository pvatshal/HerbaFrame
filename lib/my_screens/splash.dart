import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/home.dart';
import 'package:image_editor_tutorial/my_screens/welcome.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_editor_tutorial/services/update_service.dart';
import 'package:launch_review/launch_review.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/.env.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLoading = true;

  String screen = '';



  Future<void> getUpdate() async {

    final prefs = await SharedPreferences.getInstance();

    setState(() {
      isLoading = true;
    });
    screen = (prefs.getString('screen') ?? "1");



    UpdateVersionService.getVersion().then((value) {
      if(value!=null){
        setState(() {
          if(value.update=="5.0.0"){
            print("jje");

            if(screen=="HomeScreen"){
              Timer(Duration(milliseconds: 1500),
                      ()=>Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          HomePageScreen()
                      )
                  )
              );
            }else if(screen=="WelcomeScreen"){
              Timer(Duration(milliseconds: 1500),
                      ()=>Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          WelcomeScreen()
                      )
                  )
              );
            }else{
              Timer(Duration(milliseconds: 1500),
                      ()=>Navigator.pushReplacement(context,
                      MaterialPageRoute(builder:
                          (context) =>
                          WelcomeScreen()
                      )
                  )
              );
            }

          }else{
            print("Update");
            LaunchReview.launch();
          }

        });
      }
    });

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpdate();
  }



  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: RoyalBlue,
      body: Center(
        child: Column(
          children: [
            Container(
              height: height*0.2,
            ),
            Container(
              height: height*0.6,
              child: Image.asset("graphic_res/ggif.gif"),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: height*0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: height*0.1,
                      child: Text("Checking for updates",style: TextStyle(color: Colors.white),)),
                  Container(
                    alignment: Alignment.topCenter,
                      height: height*0.1,
                      child: Lottie.asset("graphic_res/92288-checking.json")),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
