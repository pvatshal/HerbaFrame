import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'dart:math' as math;

import '../screens/edit_image_screen.dart';


class EditFrameScreen extends StatefulWidget {
  const EditFrameScreen({Key? key}) : super(key: key);

  @override
  _EditFrameScreenState createState() => _EditFrameScreenState();
}

class _EditFrameScreenState extends State<EditFrameScreen> {

  int selectedLayout = 0;


  List<String> chrismus = [
    "graphic_res/1.jpg",
    "graphic_res/2.jpg",
    "graphic_res/3.jpg",
    "graphic_res/4.jpg",
    "graphic_res/5.jpg",
    "graphic_res/6.jpg",
    "graphic_res/7.jpg",
    "graphic_res/8.jpg",
    "graphic_res/9.jpg",
    "graphic_res/10.jpg",
  ];

  late int selected = 0;

  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height-100;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: RoyalBlue,
      appBar: AppBar(
        backgroundColor: RoyalOrange,
        centerTitle: true,
        title: Text("Edit Frame",
          style: GoogleFonts.poppins(
              color: RoyalBlue,
              fontSize: 20,
              fontWeight: FontWeight.w600),),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(FontAwesomeIcons.draft2digital,color: Colors.white,),
        ),

      ),

      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              height: height*0.25,
              width: width,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: Container(
                      height: height*0.19,
                      width: height*0.19,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10)

                      ),
                      child: InkWell(
                        onTap: (){
                          setState(() {
                            selectedLayout = 0;
                          });
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: height*0.19,
                          width: height*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                        width: height*0.19*0.3,
                                      child: Text("Logo",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Title",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Social",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomLeft,
                                      width: height*0.19*0.6,
                                      child: Container(
                                          decoration: const BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                            color: Colors.teal,
                                          ),
                                          height: width*0.13,
                                          child:
                                          Row(
                                            children: [
                                              Icon(FontAwesomeIcons.mapPin,color: Colors.white,),
                                              Flexible(child: Text("Address",style: TextStyle(color: Colors.white,fontSize: 10))),
                                            ],
                                          )

                                      ),
                                    ),
                                    Container(
                                      width: height*0.19*0.4,
                                      color: Colors.green,
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Colors.pinkAccent,

                                            ),
                                            height:  height*0.19*0.33*0.5,
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(FontAwesomeIcons.phone,color: Colors.white,size: 14,),
                                                Flexible(child: Text("phone",style: TextStyle(color: Colors.white,fontSize: 10))),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black,
                                                  offset: Offset(
                                                    0.0,
                                                    1.0,
                                                  ),
                                                  blurRadius: 3.0,
                                                ),
                                              ],
                                              color: Colors.orangeAccent,

                                            ),
                                            height:  height*0.19*0.33*0.5,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(Icons.email,color: Colors.white,size: 14,),
                                                Flexible(child: Text("email",style: TextStyle(color: Colors.white,fontSize: 10))),
                                              ],
                                            ),

                                          ),


                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedLayout = 1;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: height*0.19,
                          width: height*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Logo",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Title",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Social",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      height:height*0.19*0.33*0.65,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height: height*0.19*0.33*0.6,
                                            alignment: Alignment.centerLeft,
                                            width: height*0.19,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.19*0.33*0.6,
                                              width: height*0.19*0.55,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.email,color: Colors.white,size: 5,),
                                                  Text(
                                                    " Email",style:  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 5,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: height*0.19*0.33*0.6,
                                            alignment: Alignment.centerRight,
                                            width: height*0.19,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: height*0.19*0.33*0.6,
                                              width: height*0.19*0.55,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius.circular(20)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(FontAwesomeIcons.phone,color: Colors.white,size: 5,),
                                                  Text(
                                                    " Phone",style:  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 5,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      height:height*0.19*0.33*0.35,
                                      child: FittedBox(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(FontAwesomeIcons.mapPin,color: Colors.white,size: 6,),
                                            Text(
                                              " Address",style:  GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500),
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedLayout = 2;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: height*0.19,
                          width: height*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Logo",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Title",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Social",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      height:height*0.19*0.33*0.65,
                                      child: Stack(
                                        children: [
                                          Container(
                                            height:height*0.19*0.33*0.6,
                                            width: height*0.19,
                                            alignment: Alignment.center,
                                            child: Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                height:height*0.19*0.33*0.6,
                                                width: height*0.19*0.3,
                                                decoration: BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                                    border: Border.all(color: Colors.black)
                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.email,color: Colors.white,size: 8,),
                                                    Text(
                                                      " Email",style:  GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 5,
                                                        fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                height:height*0.19*0.33*0.6,
                                                width: height*0.19*0.3,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                                    border: Border.all(color: Colors.black)

                                                ),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(FontAwesomeIcons.phone,color: Colors.black,size: 8,),
                                                    Text(
                                                      " Phone",style:  GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 5,
                                                        fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      height:height*0.19*0.33*0.35,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Icon(FontAwesomeIcons.mapPin,color: Colors.white,size: 6,),
                                            Text(
                                              " Address",style:  GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500),
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedLayout = 3;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: height*0.19,
                          width: height*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Logo",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Title",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Social",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child:  Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    Container(
                                      alignment: Alignment.topCenter,
                                      height: height*0.19*0.33*0.65,
                                      child: Container(
                                        height: height*0.19*0.33*0.4,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Transform.rotate(
                                              angle: -0.1,
                                              child: Container(
                                                color: RoyalBlue,
                                                width: height*0.19*0.3,
                                                height: height*0.19*0.33*0.4,
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons.email,color: Colors.white,size: 5,),
                                                    Text(
                                                      " Email",style:  GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 5,
                                                        fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                            ),
                                            Transform.rotate(
                                              angle: 0.1,
                                              child: Container(
                                                height: height*0.19*0.33*0.4,
                                                color: RoyalBlue,
                                                width: height*0.19*0.3,
                                                padding: EdgeInsets.only(bottom: 5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Icon(FontAwesomeIcons.phone,color: Colors.white,size: 5,),
                                                    Text(
                                                      " Phone",style:  GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 5,
                                                        fontWeight: FontWeight.w500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.purple,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      alignment: Alignment.center,
                                      height: height*0.19*0.33*0.35,
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                            Icon(FontAwesomeIcons.mapPin,color: Colors.white,size: 6,),
                                            Text(
                                              " Address",style:  GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 6,
                                                fontWeight: FontWeight.w500),
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
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedLayout = 4;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: height*0.19,
                          width: height*0.19,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Logo",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Title",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: height*0.19*0.3,
                                      child: Text("Social",style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500)),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: height*0.19,
                                height:  height*0.19*0.33,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.center,
                                      height:  height*0.19*0.33*0.25,
                                      width: height*0.19*0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                          border: Border.all(color: Colors.black)

                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.phone,color: Colors.black,size: 6,),
                                          Text(
                                            " Phone",style:  GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 6,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.center,
                                      height:  height*0.19*0.33*0.25,
                                      width: height*0.19*0.65,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                          border: Border.all(color: Colors.black)

                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.email,color: Colors.black,size: 6,),
                                          Text(
                                            " Email",style:  GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 6,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 20),
                                      alignment: Alignment.center,
                                      height:  height*0.19*0.33*0.25,
                                      width: height*0.19*0.8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                          border: Border.all(color: Colors.black)

                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(FontAwesomeIcons.phone,color: Colors.black,size: 6,),
                                          Text(
                                            " Address",style:  GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 6,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Container(
                                    //   padding: EdgeInsets.symmetric(horizontal: 10),
                                    //   alignment: Alignment.centerLeft,
                                    //   height: width*0.07,
                                    //   child: FittedBox(
                                    //     child: Row(
                                    //       children: [
                                    //         Icon(FontAwesomeIcons.mapPin,color: Colors.black,size: 16,),
                                    //         Text(
                                    //           " "+address,style:  GoogleFonts.poppins(
                                    //             color: Colors.black,
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.w500),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: height*0.2,
                    width: height*0.2,
                    child: InkWell(
                      onTap: (){
                        setState(() {
                          selectedLayout = 5;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              alignment: Alignment.center,
              height: height*0.5,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: width*0.8,
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: width*0.8,
                      width: width*0.8,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(chrismus[selected])
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: width*0.8,
                            height: width*0.2,
                            child: Row(
                              children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    width: width*0.8*0.25,
                                    child: Image.asset("graphic_res/logo_temp.png"),
                                  ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  alignment: Alignment.topCenter,
                                  width: width*0.8*0.49,
                                  child: Text("Hextech",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  height: width*0.2,
                                  alignment: Alignment.bottomRight,
                                  width: width*0.8*0.25,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset("graphic_res/insta_.png",height: width*0.2*0.2,width: width*0.2*0.2,),
                                      Image.asset("graphic_res/faccebook_.png",height: width*0.2*0.2,width: width*0.2*0.2,),
                                      Image.asset("graphic_res/whatssapp_.png",height: width*0.2*0.2,width: width*0.2*0.2,fit: BoxFit.fill,),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          (){
                          if(selectedLayout==0){
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: width*0.8*0.6,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                              blurRadius: 3.0,
                                            ),
                                          ],
                                          color: Colors.teal,
                                        ),
                                        height: width*0.13,
                                        child:
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.mapPin,color: Colors.white,),
                                            Flexible(child: Text("H-104, Shivalik Enterprise, Bopal, Ahmedabad",style: TextStyle(color: Colors.white,fontSize: 10))),
                                          ],
                                        )

                                    ),
                                  ),
                                  Container(
                                    width: width*0.8*0.4,
                                    color: Colors.green,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                            color: Colors.pinkAccent,

                                          ),
                                          height: width*0.09,
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(FontAwesomeIcons.phone,color: Colors.white,size: 18,),
                                              Flexible(child: Text("+91 9904995583",style: TextStyle(color: Colors.white,fontSize: 10))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                            color: Colors.orangeAccent,

                                          ),
                                          height: width*0.11,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.email,color: Colors.white,size: 18,),
                                              Flexible(child: Text("Vatsal@gmail.com",style: TextStyle(color: Colors.white,fontSize: 10))),
                                            ],
                                          ),

                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }else if(selectedLayout==1){
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: width*0.13,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: width*0.09,
                                          alignment: Alignment.centerLeft,
                                          width: width*0.8,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: width*0.09,
                                            width: width*0.8*0.55,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.email,color: Colors.white,size: 12,),
                                                Text(
                                                  " "+email,style:  GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: width*0.09,
                                          alignment: Alignment.centerRight,
                                          width: width*0.8,
                                          child: Container(
                                            alignment: Alignment.center,
                                            height: width*0.09,
                                            width: width*0.8*0.55,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(FontAwesomeIcons.phone,color: Colors.white,size: 12,),
                                                Text(
                                                  " "+phone,style:  GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    height: width*0.07,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.mapPin,color: Colors.black,size: 16,),
                                          Text(
                                            " "+address,style:  GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }else if(selectedLayout==2){
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    height: width*0.13,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: width*0.09,
                                          width: width*0.8,
                                          alignment: Alignment.center,
                                          child: Divider(
                                            thickness: 2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              height: width*0.09,
                                              width: width*0.8*0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                                border: Border.all(color: Colors.black)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.email,color: Colors.white,size: 8,),
                                                  Text(
                                                    " "+email,style:  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              height: width*0.09,
                                              width: width*0.8*0.3,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                                  border: Border.all(color: Colors.black)

                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(FontAwesomeIcons.phone,color: Colors.black,size: 8,),
                                                  Text(
                                                    " "+phone,style:  GoogleFonts.poppins(
                                                      color: Colors.black,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    height: width*0.07,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.mapPin,color: Colors.black,size: 16,),
                                          Text(
                                            " "+address,style:  GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if(selectedLayout==3){
                            return Container(
                              alignment: Alignment.bottomCenter,
                              width: width*0.8,
                              height: width*0.2,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    height: width*0.13,
                                    child: Container(
                                      height: width*0.08,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Transform.rotate(
                                            angle: -0.1,
                                            child: Container(
                                              color: RoyalBlue,
                                              width: width*0.3,
                                              height: width*0.08,
                                              padding: EdgeInsets.only(bottom: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.email,color: Colors.white,size: 8,),
                                                  Text(
                                                    " "+email,style:  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ),
                                          Transform.rotate(
                                            angle: 0.1,
                                            child: Container(
                                              height: width*0.08,
                                              color: RoyalBlue,
                                              width: width*0.3,
                                              padding: EdgeInsets.only(bottom: 5),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(FontAwesomeIcons.phone,color: Colors.white,size: 8,),
                                                  Text(
                                                    " "+phone,style:  GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 8,
                                                      fontWeight: FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                  ),

                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    alignment: Alignment.center,
                                    height: width*0.07,
                                    child: FittedBox(
                                      child: Row(
                                        children: [
                                          Icon(FontAwesomeIcons.mapPin,color: Colors.white,size: 16,),
                                          Text(
                                            " "+address,style:  GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if(selectedLayout==4){
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    alignment: Alignment.center,
                                    height: width*0.05,
                                    width: width*0.8*0.5,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                        border: Border.all(color: Colors.black)

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(FontAwesomeIcons.phone,color: Colors.black,size: 8,),
                                        Text(
                                          " "+phone,style:  GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    alignment: Alignment.center,
                                    height: width*0.05,
                                    width: width*0.8*0.65,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                        border: Border.all(color: Colors.black)

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(Icons.email,color: Colors.black,size: 8,),
                                        Text(
                                          " "+email,style:  GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    alignment: Alignment.center,
                                    height: width*0.05,
                                    width: width*0.8*0.8,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                        border: Border.all(color: Colors.black)

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(FontAwesomeIcons.phone,color: Colors.black,size: 8,),
                                        Text(
                                          " "+address,style:  GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                                  //   alignment: Alignment.centerLeft,
                                  //   height: width*0.07,
                                  //   child: FittedBox(
                                  //     child: Row(
                                  //       children: [
                                  //         Icon(FontAwesomeIcons.mapPin,color: Colors.black,size: 16,),
                                  //         Text(
                                  //           " "+address,style:  GoogleFonts.poppins(
                                  //             color: Colors.black,
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.w500),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          }else if(selectedLayout==5){
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    color: Colors.red,
                                  )


                                  // Container(
                                  //   padding: EdgeInsets.symmetric(horizontal: 10),
                                  //   alignment: Alignment.centerLeft,
                                  //   height: width*0.07,
                                  //   child: FittedBox(
                                  //     child: Row(
                                  //       children: [
                                  //         Icon(FontAwesomeIcons.mapPin,color: Colors.black,size: 16,),
                                  //         Text(
                                  //           " "+address,style:  GoogleFonts.poppins(
                                  //             color: Colors.black,
                                  //             fontSize: 16,
                                  //             fontWeight: FontWeight.w500),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            );
                          }else{
                            return Container(
                              width: width*0.8,
                              height: width*0.2,
                              child: Row(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    width: width*0.8*0.6,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black,
                                              offset: Offset(
                                                0.0,
                                                1.0,
                                              ),
                                              blurRadius: 3.0,
                                            ),
                                          ],
                                          color: Colors.teal,
                                        ),
                                        height: width*0.13,
                                        child:
                                        Row(
                                          children: [
                                            Icon(FontAwesomeIcons.mapPin,color: Colors.white,),
                                            Flexible(child: Text("H-104, Shivalik Enterprise, Bopal, Ahmedabad",style: TextStyle(color: Colors.white,fontSize: 10))),
                                          ],
                                        )

                                    ),
                                  ),
                                  Container(
                                    width: width*0.8*0.4,
                                    color: Colors.green,
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                            color: Colors.pinkAccent,

                                          ),
                                          height: width*0.09,
                                          child:  Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(FontAwesomeIcons.phone,color: Colors.white,size: 18,),
                                              Flexible(child: Text("+91 9904995583",style: TextStyle(color: Colors.white,fontSize: 10))),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black,
                                                offset: Offset(
                                                  0.0,
                                                  1.0,
                                                ),
                                                blurRadius: 3.0,
                                              ),
                                            ],
                                            color: Colors.orangeAccent,

                                          ),
                                          height: width*0.11,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.email,color: Colors.white,size: 18,),
                                              Flexible(child: Text("Vatsal@gmail.com",style: TextStyle(color: Colors.white,fontSize: 10))),
                                            ],
                                          ),

                                        ),


                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          }

                          }(),

                        ],
                      ),
                    )
                  )
                ],
              ),
            ),

            Container(
              height: height*0.25,
              width: width,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: chrismus.length,
                  itemBuilder: (context, index) {
                    // print(chrismus[index]);
               return InkWell(
                 onTap: (){
                   setState(() {
                     selected=index;
                   });
                 },
                 child: Container(
                   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                   child: Image.asset(chrismus[index]),
                 ),
               );
              }),
            ),

          ],
        ),
      ),


    );
  }
}


class _Triangle extends StatelessWidget {
  const _Triangle({
    Key? key,
    required this.color,
  }) : super(key: key);
  final Color color;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: _ShapesPainter(color),
        child: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 16),
                    child: Transform.rotate(
                        angle: math.pi / 4,
                        child: Text('New',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            )))))));
  }
}
class _ShapesPainter extends CustomPainter {
  final Color color;
  _ShapesPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = color;
    var path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}