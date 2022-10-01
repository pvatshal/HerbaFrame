import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/models/login_model.dart';
import 'package:image_editor_tutorial/services/get_profile_info_by_email.dart';
import 'package:image_editor_tutorial/services/get_profile_info_by_user_id.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/styles.dart';
import 'change_logo.dart';
import 'edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var phone;
  var name;
  var address;
  var email;
  var bname;
  var logo_image;
  var user_id;

  late Login login;


  void get_details() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      phone = (prefs.getString('business_phone') ?? 0);
      name = (prefs.getString('name') ?? 0);
      address = (prefs.getString('business_address') ?? 0);
      email = (prefs.getString('business_email') ?? 0);
      bname = (prefs.getString('business_name') ?? 0);
      logo_image = (prefs.getString('logo_image') ?? 0);
      user_id = (prefs.getString('user_id') ?? 0);

      print(phone+"\n");
      print(name+"\n");
      print(logo_image);
      print(address+"\n");
      print(email+"\n");
      print(bname+"\n");
      print(user_id+"\n");



    });
    getDetails();

  }
  
  bool isLoading = true;
  
  void getDetails(){
    setState(() {
      isLoading = true;
    });

    GetProfileInfoByUserIdService.loginInfo(user_id).then((value) {
      if(value!=null){
        setState(() {

          isLoading = false;
          print(value.businessTagLine);
          login = value;

        });
      }

    });

  }
  
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_details();
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
      appBar: AppBar(
        title: Text("Profile",style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: RoyalOrange,

        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child:  InkWell(
              onTap: (){
                if(isLoading==false){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfileScreen(businessPhone: login.businessPhone,
                    name: login.name, businessEmail: login.businessEmail,
                    businessTagline: login.businessTagLine,
                    businessAddress: login.businessAddress, businessName: login.businessName, userId: login.userId,)));
                }else{

                }


              },
              child: Text("Edit",style: GoogleFonts.poppins(
                  color: RoyalBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),),
            ) ,
          )
        ],
      ),
      body: Container(
        height: height,
        width: width,
        color: RoyalBlue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
               height: height*0.15,
              width: width,
              child: Image.asset("graphic_res/profile.png"),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: height*0.05,
              width: width,
              child: Text(name,style: GoogleFonts.poppins(
                  color: RoyalOrange,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),),
            ),
            Container(
              alignment: Alignment.topCenter,
              height: height*0.05,
              width: width,
              child: Text(phone,style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),),
            ),
            Container(
              height: height*0.1,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    width: width*0.5-20,
                    height: height*0.1,
                    child: Text("Address : - ",style: GoogleFonts.poppins(
                        color: RoyalOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    width: width*0.5-20,
                    height: height*0.1,
                    child: Text(address,style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ),
            Container(
              height: height*0.07,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width*0.5-20,
                    height: height*0.07,
                    child: Text("Business Name : - ",style: GoogleFonts.poppins(
                        color: RoyalOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width*0.5-20,
                    height: height*0.07,
                    child: Text(bname,style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: height*0.07,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width*0.5-20,
                    height: height*0.07,
                    child: Text("Business Email : - ",style: GoogleFonts.poppins(
                        color: RoyalOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width*0.5-20,
                    height: height*0.07,
                    child: Text(email,style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: height*0.2,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width*0.5-20,
                    height: height*0.2,
                    child: Text("Business Logo : - ",style: GoogleFonts.poppins(
                        color: RoyalOrange,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: width*0.5-20,
                    height: height*0.2,
                    child: Image.network("https://"+logo_image),),

                ],
              ),
            ),

            Container(
              alignment: Alignment.bottomCenter,
              height: height*0.1,
              child:   InkWell(
                onTap: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangeLogoScreen()));

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
                  child:  Text("Change Logo",style:  GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700),),
                ),
              ),
            ),



          ],
        ),
      ),



    );
  }
}
