import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:image_editor_tutorial/constants/names.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as math;
import '../screens/edit_image_screen.dart';
import '../utils/utils.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';

class EditFrameTempScreen extends StatefulWidget {

  final List<String> images1;

  const EditFrameTempScreen({Key? key,required this.images1}) : super(key: key);

  @override
  _EditFrameTempScreenState createState() => _EditFrameTempScreenState();
}

class _EditFrameTempScreenState extends State<EditFrameTempScreen> {

  // int selected = 0;

  Color? selectedColor = Colors.white;

  double size = 18;
  PickerFont? _selectedFont;
  TextStyle _textStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600);


  int selectedLayout = 1;

  ScreenshotController screenshotController = ScreenshotController();



  var phone;
  var name;
  var address;
  var email;
  var bname;
  var logo_image;

  void get_details() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {

      phone = (prefs.getString('business_phone') ?? 0);
      name = (prefs.getString('name') ?? 0);
      address = (prefs.getString('business_address') ?? 0);
      email = (prefs.getString('business_email') ?? 0);
      bname = (prefs.getString('business_name') ?? 0);
      logo_image = (prefs.getString('logo_image') ?? 0);

      print(phone+"\n");
      print(name+"\n");
      print(logo_image);
      print(address+"\n");
      print(email+"\n");
      print(bname+"\n");


    });
  }

  saveToGallery(BuildContext context) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Image saved to gallery.'),
          ),
        );
      }).catchError((err) => print(err));

  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }


  late int selected = 0;

  var top = 0.0;
  var left = 0.0;
  var top1 = 0.0;
  var left1 = 0.0;



  static GlobalKey _globalKey = GlobalKey();
  Future<Null> shareScreenshot() async {
    await requestPermission(Permission.storage);

    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      // if (boundary.debugNeedsPaint) {
      //   Timer(Duration(seconds: 1), () => shareScreenshot());
      //   return null;
      // }
      ui.Image image = await boundary.toImage();
      final directory = (await getExternalStorageDirectory())!.path;
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      final RenderObject? box = context.findRenderObject();
      Share.shareFiles(['$directory/screenshot.png'],
          subject: 'Share ScreenShot',
          text: 'Share the Herba Frame App to your friends and family. https://play.google.com/store/apps/details?id=com.herbaframe.app',
          // sharePositionOrigin: box.localToGlobal(Offset.zero)! & box.size
      );
    } on PlatformException catch (e) {
      print("Exception while taking screenshot:" + e.toString());
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

    List<String> chrismus = widget.images1;
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height-AppBar().preferredSize.height-safe;
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
          icon: Icon(FontAwesomeIcons.solidCircleLeft,color: RoyalBlue,),
        ),
        actions: [
          IconButton(
              onPressed: (){
                  shareScreenshot();
              },
              icon: Icon(FontAwesomeIcons.shareAlt)
          ),

          IconButton(
            onPressed: (){
              saveToGallery(context);
            },
            icon: Icon(FontAwesomeIcons.download,color: Colors.white,),
          ),

        ],


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
                  // Container(
                  //   alignment: Alignment.center,
                  //   height: height*0.2,
                  //   width: height*0.2,
                  //   child: Container(
                  //     height: height*0.19,
                  //     width: height*0.19,
                  //     decoration: BoxDecoration(
                  //         color: Colors.grey.withOpacity(0.5),
                  //         borderRadius: BorderRadius.circular(10)
                  //
                  //     ),
                  //     child: InkWell(
                  //       onTap: (){
                  //         setState(() {
                  //           selectedLayout = 0;
                  //         });
                  //       },
                  //       child: Container(
                  //         alignment: Alignment.centerLeft,
                  //         height: height*0.19,
                  //         width: height*0.19,
                  //         child: Column(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Container(
                  //               width: height*0.19,
                  //               height:  height*0.19*0.33,
                  //               child: Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Container(
                  //                     alignment: Alignment.center,
                  //                     width: height*0.19*0.3,
                  //                     child: Text("Logo",style: GoogleFonts.poppins(
                  //                         color: Colors.white,
                  //                         fontSize: 8,
                  //                         fontWeight: FontWeight.w500)),
                  //                   ),
                  //                   Container(
                  //                     alignment: Alignment.center,
                  //                     width: height*0.19*0.3,
                  //                     child: Text("Title",style: GoogleFonts.poppins(
                  //                         color: Colors.white,
                  //                         fontSize: 10,
                  //                         fontWeight: FontWeight.w500)),
                  //                   ),
                  //                   Container(
                  //                     alignment: Alignment.center,
                  //                     width: height*0.19*0.3,
                  //                     child: Text("Social",style: GoogleFonts.poppins(
                  //                         color: Colors.white,
                  //                         fontSize: 8,
                  //                         fontWeight: FontWeight.w500)),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //             Container(
                  //               width: height*0.19,
                  //               height:  height*0.19*0.33,
                  //               child: Row(
                  //                 children: [
                  //                   Container(
                  //                     alignment: Alignment.bottomLeft,
                  //                     width: height*0.19*0.6,
                  //                     child: Container(
                  //                         decoration: const BoxDecoration(
                  //                           boxShadow: [
                  //                             BoxShadow(
                  //                               color: Colors.black,
                  //                               offset: Offset(
                  //                                 0.0,
                  //                                 1.0,
                  //                               ),
                  //                               blurRadius: 3.0,
                  //                             ),
                  //                           ],
                  //                           color: Colors.teal,
                  //                         ),
                  //                         height: width*0.13,
                  //                         child:
                  //                         Row(
                  //                           children: [
                  //                             Icon(FontAwesomeIcons.mapPin,color: Colors.white,),
                  //                             Flexible(child: Text("Address",style: TextStyle(color: Colors.white,fontSize: 10))),
                  //                           ],
                  //                         )
                  //
                  //                     ),
                  //                   ),
                  //                   Container(
                  //                     width: height*0.19*0.4,
                  //                     color: Colors.green,
                  //                     child: Column(
                  //                       children: [
                  //                         Container(
                  //                           decoration: BoxDecoration(
                  //                             boxShadow: [
                  //                               BoxShadow(
                  //                                 color: Colors.black,
                  //                                 offset: Offset(
                  //                                   0.0,
                  //                                   1.0,
                  //                                 ),
                  //                                 blurRadius: 3.0,
                  //                               ),
                  //                             ],
                  //                             color: Colors.pinkAccent,
                  //
                  //                           ),
                  //                           height:  height*0.19*0.33*0.5,
                  //                           child:  Row(
                  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                             children: [
                  //                               Icon(FontAwesomeIcons.phone,color: Colors.white,size: 14,),
                  //                               Flexible(child: Text("phone",style: TextStyle(color: Colors.white,fontSize: 10))),
                  //                             ],
                  //                           ),
                  //                         ),
                  //                         Container(
                  //                           decoration: BoxDecoration(
                  //                             boxShadow: [
                  //                               BoxShadow(
                  //                                 color: Colors.black,
                  //                                 offset: Offset(
                  //                                   0.0,
                  //                                   1.0,
                  //                                 ),
                  //                                 blurRadius: 3.0,
                  //                               ),
                  //                             ],
                  //                             color: Colors.orangeAccent,
                  //
                  //                           ),
                  //                           height:  height*0.19*0.33*0.5,
                  //                           child: Row(
                  //                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //                             children: [
                  //                               Icon(Icons.email,color: Colors.white,size: 14,),
                  //                               Flexible(child: Text("email",style: TextStyle(color: Colors.white,fontSize: 10))),
                  //                             ],
                  //                           ),
                  //
                  //                         ),
                  //
                  //
                  //                       ],
                  //                     ),
                  //                   ),
                  //
                  //                 ],
                  //               ),
                  //             ),
                  //
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                        child: Image.asset("graphic_res/temp_frame12.png"),
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
                          selectedLayout = 6;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: Image.asset("graphic_res/temp_frame2.png"),
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
                          selectedLayout = 7;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: Image.asset("graphic_res/temp_frame3.png"),
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
                          selectedLayout = 8;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: Image.asset("graphic_res/temp_frame4.png"),
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
                          selectedLayout = 9;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: Image.asset("graphic_res/temp_frame5.png"),
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
                          selectedLayout = 10;
                        });
                      },
                      child: Container(
                        height: height*0.19,
                        width: height*0.19,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)

                        ),
                        child: Image.asset("graphic_res/temp_frame6.png"),
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
              child: RepaintBoundary(
                key: _globalKey,
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    color: Colors.red,
                    height: width,
                    width: width,
                    child:

                    (){
                      if(selectedLayout==5)
                      {
                        return Container(
                            height: width,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              height: width,
                              width: width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                      image: NetworkImage(chrismus[selected])
                                  )
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                    height: width,
                                    width: width,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage("graphic_res/temp_frame12.png")
                                      )
                                    ),
                                  ),
                                  Container(
                                    height: width,
                                    width: width,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          alignment: Alignment.centerRight,
                                          height: width*0.23,
                                            // child: Container(
                                            //   height: width*0.23,
                                            //   width: width*0.23,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   // child: Image.network("https://"+logo_image),
                                            // ),
                                        ),
                                        Container(
                                          height: width*0.3,

                                        ),
                                        Container(
                                          height: width*0.17,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: width*0.07,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(left: width*0.06),
                                                      width: width*0.23,
                                                      child: FittedBox(
                                                          child: Text(phone,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                          )),

                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(left: width*0.09),
                                                      width: width*0.3,
                                                      child: FittedBox(
                                                          child: Text(email,
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.black,
                                                                fontSize: 14,
                                                                fontWeight: FontWeight.w500),
                                                          )),

                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.bottomLeft,
                                                width: width,
                                                height: width*0.1,
                                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                                                child:  FittedBox(
                                                    child: Text("Address : "+address,
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w500),
                                                    )),

                                              )
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width,
                                    height: width,
                                    child: GestureDetector(
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            top: top,
                                            left: left,
                                            child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                        ],
                                      ),
                                      onVerticalDragUpdate: (DragUpdateDetails dd){
                                        setState(() {
                                          top = dd.localPosition.dy-50;
                                          left = dd.localPosition.dx-50;
                                        });
                                      },
                                    ),

                                  ),
                                  Container(
                                    width: width,
                                    height: width,
                                    child: GestureDetector(
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top:  top1==0 ? 5.0 : top1,
                                              left: left1==0 ? width*0.4 : left1,
                                              child: Text(bname,style: _textStyle,))
                                        ],
                                      ),
                                      onVerticalDragUpdate: (DragUpdateDetails dd){
                                        setState(() {
                                          top1 = dd.localPosition.dy-50;
                                          left1 = dd.localPosition.dx-50;
                                        });
                                      },
                                    ),

                                  ),

                                ],
                              )
                            )
                        );
                      }
                      else if(selectedLayout==6)
                      {
                        return Container(
                            height: width,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(chrismus[selected])
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width,
                                      width: width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage("graphic_res/temp_frame2.png")
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: width,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: width*0.2,
                                            // child: Container(
                                            //   height: width*0.2,
                                            //   width: width*0.2,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     // color: Colors.white70,
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   child: Image.network("https://"+logo_image),
                                            // ),
                                          ),
                                          Container(
                                            height: width*0.3,
                                          ),
                                          Container(
                                            height: width*0.2,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: width*0.1,
                                                  child: Container(
                                                    // padding: EdgeInsets.only(left: width*0.06),
                                                    // width: width*0.23,
                                                    child: FittedBox(
                                                        child: Text(name,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white,
                                                              // fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        )),

                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: width,
                                                  height: width*0.1,
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: width*0.3,
                                                        child: FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Icon(FontAwesomeIcons.phone,color: Colors.white,size: 16,),
                                                                Text("  "+phone,
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.white,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Container(
                                                        width: width*0.5,
                                                        child: Text("Address : "+address,
                                                          maxLines: 3,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: top,
                                              left: left,
                                              child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-50;
                                            left = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1==0 ? 5.0 : top1,
                                                left: left1==0 ? width*0.4 : left1,
                                                child: Text(bname,style: _textStyle,))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-50;
                                            left1 = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),


                                  ],
                                )
                            )
                        );
                      }
                      else if(selectedLayout==7)
                      {
                        return Container(
                            height: width,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(chrismus[selected])
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width,
                                      width: width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage("graphic_res/temp_frame3.png")
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: width,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: width*0.2,
                                            // child: Container(
                                            //   height: width*0.2,
                                            //   width: width*0.2,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     // color: Colors.white70,
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   child: Image.network("https://"+logo_image),
                                            // ),
                                          ),
                                          Container(
                                            height: width*0.3,
                                          ),
                                          Container(
                                            height: width*0.2,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: width*0.1,
                                                  child: Container(
                                                    // padding: EdgeInsets.only(left: width*0.06),
                                                    // width: width*0.23,
                                                    child: FittedBox(
                                                        child: Text(name,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              // fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        )),

                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: width,
                                                  height: width*0.1,
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: width*0.3,
                                                        child: FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Icon(FontAwesomeIcons.phone,color: Colors.black,size: 16,),
                                                                Text("  "+phone,
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Container(
                                                        width: width*0.45,
                                                        child: Text("Address : "+address,
                                                          maxLines: 3,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: top,
                                              left: left,
                                              child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-50;
                                            left = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1==0 ? 5.0 : top1,
                                                left: left1==0 ? width*0.4 : left1,
                                                child: Text(bname,style: _textStyle,))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-50;
                                            left1 = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),

                                  ],
                                )
                            )
                        );
                      }
                      else if(selectedLayout==8)
                      {
                        return Container(
                            height: width,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(chrismus[selected])
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width,
                                      width: width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage("graphic_res/temp_frame4.png")
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: width,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: width*0.2,
                                            // child: Container(
                                            //   height: width*0.2,
                                            //   width: width*0.2,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     // color: Colors.white70,
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   child: Image.network("https://"+logo_image),
                                            // ),
                                          ),
                                          Container(
                                            height: width*0.3,
                                          ),
                                          Container(
                                            height: width*0.2,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: width*0.1,
                                                  child: Container(
                                                    // padding: EdgeInsets.only(left: width*0.06),
                                                    // width: width*0.23,
                                                    child: FittedBox(
                                                        child: Text(name,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              // fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        )),

                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: width,
                                                  height: width*0.1,
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Container(
                                                            height: width*0.05,
                                                            width: width*0.3,
                                                            child: FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(FontAwesomeIcons.phone,color: Colors.black,size: 16,),
                                                                    Text("  "+phone,
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors.black,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                          Container(
                                                            height: width*0.05,
                                                            width: width*0.3,
                                                            child: FittedBox(
                                                                child: Row(
                                                                  children: [
                                                                    Icon(Icons.email,color: Colors.black,size: 16,),
                                                                    Text("  "+email,
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors.black,
                                                                          fontSize: 14,
                                                                          fontWeight: FontWeight.w500),
                                                                    ),
                                                                  ],
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: width*0.45,
                                                        child: Text("Address : "+address,
                                                          maxLines: 3,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.black,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: top,
                                              left: left,
                                              child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-50;
                                            left = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1==0 ? 5.0 : top1,
                                                left: left1==0 ? width*0.4 : left1,
                                                child: Text(bname,style: _textStyle,))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-50;
                                            left1 = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),

                                  ],
                                )
                            )
                        );
                      }
                      else if(selectedLayout==9)
                      {
                        return Container(
                            height: width,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(chrismus[selected])
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width,
                                      width: width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage("graphic_res/temp_frame5.png")
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: width,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: width*0.2,
                                            // child: Container(
                                            //   height: width*0.2,
                                            //   width: width*0.2,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     // color: Colors.white70,
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   child: Image.network("https://"+logo_image),
                                            // ),
                                          ),
                                          Container(
                                            height: width*0.3,
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            height: width*0.15,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: width,
                                              height: width*0.1,
                                              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                                              child:  Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Container(
                                                        height: width*0.05,
                                                        width: width*0.3,
                                                        child: FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Icon(FontAwesomeIcons.phone,color: Colors.black,size: 16,),
                                                                Text("  "+phone,
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Container(
                                                        height: width*0.05,
                                                        width: width*0.3,
                                                        child: FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Icon(Icons.email,color: Colors.black,size: 16,),
                                                                Text("  "+email,
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.black,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    width: width*0.45,
                                                    child: Text("Address : "+address,
                                                      maxLines: 3,
                                                      style: GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 10,
                                                          fontWeight: FontWeight.w500),
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
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: top,
                                              left: left,
                                              child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-50;
                                            left = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1==0 ? 5.0 : top1,
                                                left: left1==0 ? width*0.4 : left1,
                                                child: Text(bname,style: _textStyle,))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-50;
                                            left1 = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),


                                  ],
                                )
                            )
                        );
                      }
                      else if(selectedLayout==10)
                      {
                        return Container(
                            height: width,
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: width,
                                width: width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: NetworkImage(chrismus[selected])
                                    )
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      height: width,
                                      width: width,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage("graphic_res/temp_frame6.png")
                                          )
                                      ),
                                    ),
                                    Container(
                                      height: width,
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            height: width*0.2,
                                            // child: Container(
                                            //   height: width*0.2,
                                            //   width: width*0.2,
                                            //   padding : EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                            //   decoration: BoxDecoration(
                                            //     // color: Colors.white70,
                                            //     borderRadius: BorderRadius.circular(50),
                                            //   ),
                                            //   child: Image.network("https://"+logo_image),
                                            // ),
                                          ),
                                          Container(
                                            height: width*0.3,
                                          ),
                                          Container(
                                            height: width*0.2,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  width: width,
                                                  height: width*0.1,
                                                  child: Container(
                                                    // padding: EdgeInsets.only(left: width*0.06),
                                                    // width: width*0.23,
                                                    child: FittedBox(
                                                        child: Text(name,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white,
                                                              // fontSize: 14,
                                                              fontWeight: FontWeight.w500),
                                                        )),

                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: width,
                                                  height: width*0.1,
                                                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 2),
                                                  child:  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Container(
                                                        width: width*0.3,
                                                        child: FittedBox(
                                                            child: Row(
                                                              children: [
                                                                Icon(FontAwesomeIcons.phone,color: Colors.white,size: 16,),
                                                                Text("  "+phone,
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors.white,
                                                                      fontSize: 14,
                                                                      fontWeight: FontWeight.w500),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                      Container(
                                                        width: width*0.5,
                                                        child: Text("Address : "+address,
                                                          maxLines: 3,
                                                          style: GoogleFonts.poppins(
                                                              color: Colors.white,
                                                              fontSize: 10,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                )
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: top,
                                              left: left,
                                              child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-50;
                                            left = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),
                                    Container(
                                      width: width,
                                      height: width,
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1==0 ? 5.0 : top1,
                                                left: left1==0 ? width*0.4 : left1,
                                                child: Text(bname,style: _textStyle,))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-50;
                                            left1 = dd.localPosition.dx-50;
                                          });
                                        },
                                      ),

                                    ),

                                  ],
                                )
                            )
                        );
                      }
                      else{
                        return Container(
                          width: width,
                            height: width,
                            child: Stack(
                              children: [
                                Container(
                                  height: width,
                                  width: width,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                          image: NetworkImage(chrismus[selected])
                                      )
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: width,
                                        height: width*0.2,
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: width*0.25,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 5),
                                              alignment: Alignment.topCenter,
                                              width: width*0.49,
                                              // child: Text("Hextech",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(vertical: 5),
                                              height: width*0.2,
                                              alignment: Alignment.bottomRight,
                                              width: width*0.25,
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
                                            width: width,
                                            height: width*0.2,
                                            child: Row(
                                              children: [
                                                Container(
                                                  alignment: Alignment.bottomLeft,
                                                  width: width*0.6,
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
                                                          Flexible(child: Text(address,style: TextStyle(color: Colors.white,fontSize: 10))),
                                                        ],
                                                      )

                                                  ),
                                                ),
                                                Container(
                                                  width: width*0.4,
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
                                                            Flexible(child: Text(phone,style: TextStyle(color: Colors.white,fontSize: 10))),
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
                                                            Flexible(child: Text(email,style: TextStyle(color: Colors.white,fontSize: 10))),
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
                                            width: width,
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
                                                        width: width,
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width*0.09,
                                                          width: width*0.55,
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
                                                        width: width,
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          height: width*0.09,
                                                          width: width*0.55,
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
                                            width: width,
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
                                                        width: width,
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
                                                            width: width*0.3,
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
                                                            width: width*0.3,
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
                                            width: width,
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
                                            width: width,
                                            height: width*0.2,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                                  alignment: Alignment.center,
                                                  height: width*0.05,
                                                  width: width*0.5,
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
                                                  width: width*0.65,
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
                                                  width: width*0.8,
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
                                            width: width,
                                            height: width,
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
                                                          Flexible(child: Text(address,style: TextStyle(color: Colors.white,fontSize: 10))),
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
                                                            Flexible(child: Text(phone,style: TextStyle(color: Colors.white,fontSize: 10))),
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
                                                            Flexible(child: Text(email,style: TextStyle(color: Colors.white,fontSize: 10))),
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
                                ),
                                Container(
                                  width: width,
                                  height: width,
                                  child: GestureDetector(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: top,
                                          left: left,
                                          child: Image.network("https://"+logo_image),height: 100,width: 100,),
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top = dd.localPosition.dy-50;
                                        left = dd.localPosition.dx-50;
                                      });
                                    },
                                  ),

                                ),
                                Container(
                                  width: width,
                                  height: width,
                                  child: GestureDetector(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top:  top1==0 ? 5.0 : top1,
                                          left: left1==0 ? width*0.4 : left1,
                                          child: Text(bname,style: _textStyle,))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top1 = dd.localPosition.dy-50;
                                        left1 = dd.localPosition.dx-50;
                                      });
                                    },
                                  ),

                                ),

                              ],
                            )
                        );
                      }
                    }()
                    ,
                  ),
                ),
              ),
            ),

            Container(

              height: height*0.2,
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
                        height: height*0.2,
                        width: height*0.2,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                        child: Image.network(chrismus[index],fit: BoxFit.fill,),
                      ),
                    );
                  }),
            ),
            Container(
                height: height*0.05,
                width: width,
              decoration: BoxDecoration(
                  color: RoyalOrange,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.white
                    )
                  ]
              ),
              child:   SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.font,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>
                            FontPicker(onFontChanged: (PickerFont font){
                              setState(() {
                                _textStyle = font.toTextStyle();
                                _textStyle = TextStyle(color: selectedColor,fontFamily: font.toTextStyle().fontFamily,
                                    fontStyle: font.toTextStyle().fontStyle,fontWeight: font.toTextStyle().fontWeight,fontSize: size
                                );
                                _selectedFont = font;
                              });
                              print("${font.fontFamily} with font weight ${font.fontWeight} and font style ${font.fontStyle}.}");
                            })));

                      },
                      tooltip: 'Change Font',
                    ),

                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.plus,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        setState(() {

                          // selectedColor = Colors.white;
                          size = _textStyle.fontSize!;
                          print(size);

                          size = (size +2);
                          print(size);
                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            print(size);
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight,
                                fontSize: size
                            );
                          }
                        });
                      },
                      tooltip: 'Increase Font',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.minus,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        setState(() {



                          // selectedColor = Colors.white;
                          size = _textStyle.fontSize!;
                          print(size);

                          size = (size -2);
                          print(size);
                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            print(size);
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight,
                                fontSize: size
                            );
                          }
                        });
                      },
                      tooltip: 'Increase Font',
                    ),

                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.black,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.black;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.white,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.white;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.red,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.red;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight,
                                fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.purple,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.purple;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.yellow,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.yellow;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.green,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.green;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.blue,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.blue;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.cyanAccent,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.cyanAccent;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),
                    IconButton(
                      icon: const Icon(
                        FontAwesomeIcons.solidCircle,
                        color: Colors.pink,
                      ),
                      onPressed: (){
                        setState(() {
                          selectedColor = Colors.pink;

                          if(_selectedFont==null){
                            _textStyle = GoogleFonts.poppins(
                                color: selectedColor,
                                fontSize: size,
                                fontWeight: FontWeight.w600);
                          }else{
                            _textStyle = TextStyle(color: selectedColor,fontFamily: _selectedFont!.toTextStyle().fontFamily,
                                fontStyle: _selectedFont!.toTextStyle().fontStyle,fontWeight: _selectedFont!.toTextStyle().fontWeight
                                ,fontSize: size
                            );
                          }



                        });
                      },
                      tooltip: 'Black',
                    ),




                  ],
                ),
              ),

            )

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