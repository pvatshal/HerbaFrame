import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/profile.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  void _launchURL(_url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }


  @override
  Widget build(BuildContext context) {

    void _loadCounter(phone,identifier) async {
      final prefs = await SharedPreferences.getInstance();
      setState(() {
        prefs.setString(identifier, phone);
      });
    }


    double safe = MediaQuery.of(context).padding.top;
    double height1 = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double height = height1-safe;
    return Scaffold(
      backgroundColor: RoyalBlue,
      appBar: AppBar(
        title: Text("Settings"),
        centerTitle: true,
        backgroundColor: RoyalOrange,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
        height: height,
        width: width,
        color: RoyalBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    // print("heeko");
                    // _launchURL("https://tulsivivahbureau.online/privacy-policy.html");
                  },
                  leading: Icon(FontAwesomeIcons.solidUser,color: Colors.white,),
                  title: Text("Profile",style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: RoyalOrange,fontSize: 14,fontWeight: FontWeight.w500)
                  ),),
                  trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.white,),

                ),
                ListTile(
                  onTap: (){
                    print("heeko");
                    _launchURL("https://tulsivivahbureau.online/privacy-policy.html");
                  },
                  leading: Icon(FontAwesomeIcons.userLock,color: Colors.white,),
                  title: Text("Privacy Policy",style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: RoyalOrange,fontSize: 14,fontWeight: FontWeight.w500)
                  ),),
                  trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.white,),

                ),
                ListTile(
                  onTap: (){
                    _launchURL("https://tulsivivahbureau.online/about-us.html");
                  },
                  leading: Icon(FontAwesomeIcons.users,color: Colors.white),
                  title: Text("About US",style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: RoyalOrange,fontSize: 14,fontWeight: FontWeight.w500)
                  ),),
                  trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.white,),

                ),
                ListTile(
                  onTap: (){
                    _loadCounter("RegisterScreen",'screen');
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) => WelcomeScreen()),
                          (Route<dynamic> route) => false,
                    );
                  },
                  leading: Icon(FontAwesomeIcons.signOutAlt,color: Colors.white),
                  title: Text("Log Out",style: GoogleFonts.poppins(
                      textStyle: TextStyle(color: RoyalOrange,fontSize: 14,fontWeight: FontWeight.w500)
                  ),),
                  trailing: Icon(FontAwesomeIcons.angleRight,color: Colors.white,),

                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              height: height*0.05,
              width: width,
              child: Text("Version 5.0.0",style:GoogleFonts.poppins(
                  textStyle: TextStyle(color: RoyalOrange,fontSize: 14,fontWeight: FontWeight.w500)
              ) ,),
            )
          ],
        ),

      ),
    );
  }
}
