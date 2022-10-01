import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/styles.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/utils.dart';

import 'dart:ui' as ui;
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';


class BeforeAfterFrameScreen extends StatefulWidget {

  final File file;
  final File file1;
  final String weight;
  final String recognition_name;

  const BeforeAfterFrameScreen({Key? key,required this.file,
    required this.recognition_name, required this.file1,required this.weight}) : super(key: key);

  @override
  _BeforeAfterFrameScreenState createState() => _BeforeAfterFrameScreenState();
}

class _BeforeAfterFrameScreenState extends State<BeforeAfterFrameScreen> {

  PickerFont? _selectedFont;
  TextStyle _textStyle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600);

  Color? selectedColor = Colors.white;

  double size = 18;



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

  ScreenshotController screenshotController = ScreenshotController();


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

  int selected = 0;

  var top = 0.0;
  var left = 0.0;
  var top1 = 0.0;
  var left1 = 0.0;


  static GlobalKey _globalKey = GlobalKey();
  Future<Null> shareScreenshot() async {
    try {
      final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        Timer(Duration(seconds: 1), () => shareScreenshot());
        return null;
      }
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
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height-AppBar().preferredSize.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: RoyalBlue,
      appBar: AppBar(
        backgroundColor: RoyalOrange,
        centerTitle: true,
        title: Text("Before After Frame",
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
          )
        ],

      ),
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              color: RoyalBlue,
              height: height*0.3,
              width: width,
              child: ListView.builder(
                  itemCount: 2,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        setState(() {

                          if(index==0){
                            selected=0;
                          }else if(index==1){
                            selected=1;
                          }
                        });

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        height: height*0.3,
                        width: height*0.25,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image.asset(
                              (){
                            if(index==0){
                              return "graphic_res/BeforeAfter03.png";
                            }else if(index==1){
                              return "graphic_res/Before.png";
                            }
                            return "graphic_res/BeforeAfter01.png";
                          }(),

                        ),

                      ),
                    );
                  }),
            ),
            Container(
              alignment: Alignment.center,
              color: RoyalBlue,
              height: height*0.6,
              width: width,
              child: RepaintBoundary(
                key: _globalKey,
                child: Screenshot(
                  controller: screenshotController,
                  child: Container(
                    height: height*0.55,
                    width: width,
                    child: Container(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(  (){
                            if(selected==0){
                              return "graphic_res/BeforeAfter03.png";
                            }else if(selected==1){
                              return "graphic_res/Before.png";
                            }
                            return "graphic_res/BeforeAfter01.png";
                          }(),),


                          selected==0?
                          Container(
                            height: height*0.55,
                            width: width,
                            alignment: Alignment.center,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: height*0.03),
                                  height: height*0.07,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        height: height*0.07,
                                        width: width*0.5,
                                        child: Text(widget.recognition_name,style:  GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),maxLines: 3,textAlign: TextAlign.center,),
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        height: height*0.07,
                                        width: width*0.5,
                                        child:  Text(widget.weight,style:  GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),maxLines: 3,textAlign: TextAlign.center,),

                                      ),

                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: height*0),
                                      height: height*0.3,
                                      width: width*0.4,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.orangeAccent,width: 5),
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 10,
                                                color: Colors.orangeAccent,
                                                offset: Offset(0,0)
                                            )
                                          ]
                                      ),
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top,
                                                left:  left,
                                                child: Container(
                                                  width: width*0.5,
                                                  child: Image.file(widget.file,fit: BoxFit.fill,     height: height*0.3,
                                                    width: width*0.4,),
                                                ))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-width*0.4/2;
                                            left = dd.localPosition.dx-width*0.4/2;
                                          });
                                        },
                                      ),

                                      // child: Image.file(widget.file,fit: BoxFit.fill,)
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: height*0),
                                      height: height*0.3,
                                      width: width*0.4,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.orangeAccent,width: 5),
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 10,
                                            color: Colors.orangeAccent,
                                            offset: Offset(0,0)
                                          )
                                        ]
                                      ),
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top1,
                                                left:  left1,
                                                child: Container(
                                                  width: width*0.5,
                                                  child: Image.file(widget.file1,fit: BoxFit.fill,
                                                    height: height*0.3,
                                                    width: width*0.4,),
                                                ))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top1 = dd.localPosition.dy-width*0.3/2;
                                            left1 = dd.localPosition.dx-width*0.4/2;
                                          });
                                        },
                                      ),

                                      // child: Image.file(widget.file,fit: BoxFit.fill,)
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          )
                              :
                          selected==1?
                          Container(
                            height: height*0.55,
                            width: width,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [

                                Stack(
                                  // alignment: Alignment.center,
                                  children: [





                                    Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(bottom: height*0),
                                      height: height*0.3,
                                      width: width*0.4,
                                      decoration: BoxDecoration(

                                      ),
                                      child: GestureDetector(
                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top:  top,
                                                left:  left,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(20)
                                                  ),
                                                  width: width*0.4,
                                                  child: Image.file(widget.file,fit: BoxFit.fill,     height: height*0.3,
                                                    width: width*0.4,),
                                                ))
                                          ],
                                        ),
                                        onVerticalDragUpdate: (DragUpdateDetails dd){
                                          setState(() {
                                            top = dd.localPosition.dy-width*0.4/2;
                                            left = dd.localPosition.dx-width*0.4/2;
                                          });
                                        },
                                      ),

                                      // child: Image.file(widget.file,fit: BoxFit.fill,)
                                    ),
                                    Container(
                                      height: height*0.5,
                                      width: width*0.7,
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        margin: EdgeInsets.only(bottom: height*0),
                                        height: height*0.3,
                                        width: width*0.4,
                                        decoration: BoxDecoration(
                                        ),
                                        child: GestureDetector(
                                          child: Stack(
                                            children: [
                                              Positioned(
                                                  top:  top1,
                                                  left:  left1,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20)
                                                    ),
                                                    width: width*0.4,
                                                    child: Image.file(widget.file1,fit: BoxFit.fill,     height: height*0.3,
                                                      width: width*0.4,),
                                                  ))
                                            ],
                                          ),
                                          onVerticalDragUpdate: (DragUpdateDetails dd){
                                            setState(() {
                                              top1 = dd.localPosition.dy-width*0.4/2;
                                              left1 = dd.localPosition.dx-width*0.4/2;
                                            });
                                          },
                                        ),

                                        // child: Image.file(widget.file,fit: BoxFit.fill,)
                                      ),
                                    ),


                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: height*0.4,right: width*0.4),
                                  alignment: Alignment.center,
                                  height: height*0.07,
                                  width: width*0.5,
                                  child: Text(widget.recognition_name,style:  GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),maxLines: 3,textAlign: TextAlign.center,),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: height*0.45,left: width*0.4),
                                  alignment: Alignment.center,
                                  height: height*0.07,
                                  width: width*0.5,
                                  child:  Text(widget.weight,style:  GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),maxLines: 3,textAlign: TextAlign.center,),

                                ),

                              ],
                            ),
                          ):

                          Container()



                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),


          ],
        ),

      ),

    );
  }
}
