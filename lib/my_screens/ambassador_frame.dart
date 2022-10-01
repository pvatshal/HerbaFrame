import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:o_color_picker/o_color_picker.dart';

import 'package:screenshot/screenshot.dart';

import '../constants/names.dart';
import '../constants/styles.dart';
import '../utils/utils.dart';

import '../utils/utils.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AmbassadorFrameScreen extends StatefulWidget {

  final File file;
  final String recognition_name;

  const AmbassadorFrameScreen({Key? key,required this.file,required this.recognition_name}) : super(key: key);

  @override
  _AmbassadorFrameScreenState createState() => _AmbassadorFrameScreenState();
}

class _AmbassadorFrameScreenState extends State<AmbassadorFrameScreen> {

  int selected = 0;

  Color? selectedColor = Colors.white;

  double size = 18;

  PickerFont? _selectedFont;
  TextStyle _textStyle = GoogleFonts.poppins(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w600);

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


  var top = 0.0;
  var left = 0.0;
  var top1 = 0.0;
  var left1 = 0.0;
  var top2 = 0.0;
  var left2 = 0.0;
  var top3 = 0.0;
  var left3 = 0.0;
  var top4 = 0.0;
  var left4 = 0.0;
  var top5 = 0.0;
  var left5 = 0.0;
  var top6 = 0.0;
  var left6 = 0.0;
  var top7 = 0.0;
  var left7 = 0.0;
  var top8 = 0.0;
  var left8 = 0.0;
  var top9 = 0.0;
  var left9 = 0.0;
  var top10 = 0.0;
  var left10 = 0.0;
  var top11 = 0.0;
  var left11 = 0.0;
  var top12= 0.0;
  var left12 = 0.0;
  var top13 = 0.0;
  var left13 = 0.0;
  var top14 = 0.0;
  var left14 = 0.0;
  var top15 = 0.0;
  var left15 = 0.0;
  var top16 = 0.0;
  var left16 = 0.0;
  var top17 = 0.0;
  var left17 = 0.0;
  var top18 = 0.0;
  var left18 = 0.0;
  var top19 = 0.0;
  var left19 = 0.0;
  var top20 = 0.0;
  var left20 = 0.0;
  var top21 = 0.0;
  var left21 = 0.0;
  var top22 = 0.0;
  var left22 = 0.0;

  var top23 = 0.0;
  var left23 = 0.0;

  var top24 = 0.0;
  var left24 = 0.0;

  var top25 = 0.0;
  var left25 = 0.0;


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
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height-AppBar().preferredSize.height-safe;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: RoyalBlue,
      appBar: AppBar(
        backgroundColor: RoyalOrange,
        centerTitle: true,
        title: Text("Ambassador Frame",
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
                  itemCount: 19,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        setState(() {

                          if(index==0){
                            selected=0;
                          }else if(index==1){
                            selected=1;
                          }else if(index==2){
                            selected=2;
                          }else if(index==3){
                            selected=3;
                          }else if(index==4){
                            selected=4;
                          }else if(index==5){
                            selected=5;
                          }else if(index==6){
                            selected=6;
                          }else if(index==7){
                            selected=7;
                          }else if(index==8){
                            selected=8;
                          }else if(index==9){
                            selected=9;
                          }else if(index==10){
                            selected=10;
                          }else if(index==11){
                            selected=11;
                          }else if(index==12){
                            selected=12;
                          }else if(index==13){
                            selected=13;
                          }else if(index==14){
                            selected=14;
                          }else if(index==15){
                            selected=15;
                          }else if(index==16){
                            selected=16;
                          }else if(index==17){
                            selected=17;
                          }else if(index==18){
                            selected=18;
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
                              return "graphic_res/silver01.png";
                            }else if(index==1){
                              return "graphic_res/silver02.png";
                            }else if(index==2){
                              return "graphic_res/silver03.png";
                            }else if(index==3){
                              return "graphic_res/silver04.png";
                            }else if(index==4){
                              return "graphic_res/gold01.png";
                            }else if(index==5){
                              return "graphic_res/gold02.png";
                            }else if(index==6){
                              return "graphic_res/gold03.png";
                            }else if(index==7){
                              return "graphic_res/gold04.png";
                            }else if(index==8){
                              return "graphic_res/gold05.png";
                            }else if(index==9){
                              return "graphic_res/gold06.png";
                            }else if(index==10){
                              return "graphic_res/platinum01.png";
                            }else if(index==11){
                              return "graphic_res/platinum02.png";
                            }else if(index==12){
                              return "graphic_res/platinum03.png";
                            }else if(index==13){
                              return "graphic_res/vipplatinum01.png";
                            }else if(index==14){
                              return "graphic_res/vipplatinum02.png";
                            }else if(index==15){
                              return "graphic_res/vipplatinum03.png";
                            }else if(index==16){
                              return "graphic_res/eliteplatinum01.png";
                            }else if(index==17){
                              return "graphic_res/eliteplatinum02.png";
                            }else if(index==18){
                              return "graphic_res/eliteplatinum03.png";
                            }
                            return "graphic_res/recognition01.png";
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
                              return "graphic_res/silver01.png";
                            }else if(selected==1){
                              return "graphic_res/silver02.png";
                            }else if(selected==2){
                              return "graphic_res/silver03.png";
                            }else if(selected==3){
                              return "graphic_res/silver04.png";
                            }else if(selected==4){
                              return "graphic_res/gold01.png";
                            }else if(selected==5){
                              return "graphic_res/gold02.png";
                            }else if(selected==6){
                              return "graphic_res/gold03.png";
                            }else if(selected==7){
                              return "graphic_res/gold04.png";
                            }else if(selected==8){
                              return "graphic_res/gold05.png";
                            }else if(selected==9){
                              return "graphic_res/gold06.png";
                            }else if(selected==10){
                              return "graphic_res/platinum01.png";
                            }else if(selected==11){
                              return "graphic_res/platinum02.png";
                            }else if(selected==12){
                              return "graphic_res/platinum03.png";
                            }else if(selected==13){
                              return "graphic_res/vipplatinum01.png";
                            }else if(selected==14){
                              return "graphic_res/vipplatinum02.png";
                            }else if(selected==15){
                              return "graphic_res/vipplatinum03.png";
                            }else if(selected==16){
                              return "graphic_res/eliteplatinum01.png";
                            }else if(selected==17){
                              return "graphic_res/eliteplatinum02.png";
                            }else if(selected==18){
                              return "graphic_res/eliteplatinum03.png";
                            }
                            return "graphic_res/recognition01.png";
                          }(),),


                          selected==0?
                          Container(
                            height: height*0.55,
                            width: width,
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [

                                Container(
                                  width: width,
                                  height: height*0.55,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top:  top3==0?  (height*0.1)/2 : top3,
                                            left: left3==0? (height*0.3)/2 : left3,
                                            child:  Container(
                                              margin: EdgeInsets.only(bottom: height*0),
                                              height: height*0.3,
                                              width: height*0.3,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(400),
                                                  image: DecorationImage(
                                                      image: FileImage(widget.file,),
                                                      fit: BoxFit.fill

                                                  )
                                              ),
                                              // child: Image.file(widget.file,fit: BoxFit.fill,)
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top3 = dd.localPosition.dy-height*0.3*0.5;
                                        left3 = dd.localPosition.dx-height*0.3*0.5;
                                      });
                                    },
                                  ),

                                ),
                                Container(
                                  width: width,
                                  height: height*0.55,
                                  child: GestureDetector(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top:  top4==0 ? (height*0.8)/2 : top4,
                                            left: left4==0 ? width*0.25 : left4,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(left: width*0.1),
                                              height: height*0.1,
                                              width: width*0.4,
                                              decoration: BoxDecoration(
                                                  color: Color(0xff2d7784),
                                                  borderRadius: BorderRadius.circular(30),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0,0),
                                                        color: Colors.white,
                                                        blurRadius: 10
                                                    )
                                                  ]
                                              ),
                                              child: Text(widget.recognition_name,style: _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top4 = dd.localPosition.dy-height*0.1*0.5;
                                        left4 = dd.localPosition.dx-width*0.4*0.5;
                                      });
                                    },
                                  ),

                                )


                              ],
                            ),
                          ) :
                          selected==1?
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top23==0 ? height*0.4/2 : top23,
                                          left:  left23==0 ? height*0.3/2 : left23,
                                          child:  Container(
                                            height: height*0.3,
                                            width: height*0.3,
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 10,
                                                        color: Colors.white
                                                    )
                                                  ],
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file
                                                      ),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                              // margin: EdgeInsets.only(left: height*0.07),
                                              height: height*0.3,
                                              width: height*0.3,
                                            ),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top23 = dd.localPosition.dy-height*0.3/2;
                                      left23 = dd.localPosition.dx-height*0.3/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top5==0 ? height*0.1/2 : top5,
                                          left: left5==0 ? width*0.4 : left5,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),

                                            ),
                                            child: Text(widget.recognition_name,style:  GoogleFonts.rubikMonoOne(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top5 = dd.localPosition.dy-height*0.1/2;
                                      left5 = dd.localPosition.dx-width*0.4/2;
                                    });
                                  },
                                ),

                              )

                            ],
                          ) :
                          selected==2?
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top6==0?height*0.1/2:top6,
                                          left:  left6==0?height*0.3/2:left6,
                                          child: Container(
                                            height:  height*0.3,
                                            width:  height*0.3,
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file
                                                      ),
                                                      fit: BoxFit.fill
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      blurRadius: 10,
                                                      color: Colors.white,
                                                    )
                                                  ]
                                              ),
                                              height: height*0.3,
                                              width: height*0.3,

                                            ),


                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top6 = dd.localPosition.dy-height*0.3/2;
                                      left6 = dd.localPosition.dx-height*0.3/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top7==0 ? height*0.7/2 : top7,
                                          left: left7==0 ? width*0.4/2 : left7,
                                          child:   Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: height*0.03),
                                            height: height*0.1,
                                            width: width*0.7,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top7 = dd.localPosition.dy-height*0.1/2;
                                      left7 = dd.localPosition.dx-width*0.7/2;
                                    });
                                  },
                                ),

                              )


                            ],
                          ) :
                          selected==3?
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top8==0? height*0.03 : top8,
                                          left: left8==0? width*0.05 : left8,
                                          child:  Container(
                                            height: height*0.3,
                                            width:height*0.3,
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(200),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.white,
                                                      blurRadius: 10
                                                    )
                                                  ],
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file
                                                      ),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                              height: height*0.3,
                                              width: height*0.3,

                                            ),


                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top8 = dd.localPosition.dy-height*0.3/2;
                                      left8 = dd.localPosition.dx-height*0.3/2;
                                    });
                                  },
                                ),

                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top9==0 ? height*0.8/2 : top9,
                                          left: left9==0 ? width*0.45 : left9,
                                          child:  Container(

                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top9 = dd.localPosition.dy-height*0.1/2;
                                      left9 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )




                            ],
                          ):
                          selected==4?
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  margin: EdgeInsets.only(top: height*0.055,left: width*0.07),
                                  height: height*0.45,
                                  width: height*0.22,

                                ),


                              )
                              ,
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top10==0 ? height*0.1/2 : top10,
                                          left: left10==0 ? width*0.45 : left10,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top10 = dd.localPosition.dy-height*0.1/2;
                                      left10 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )

                             ,


                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==5?
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  margin: EdgeInsets.only(top: height*0.055,left: width*0.07),
                                  height: height*0.45,
                                  width: height*0.22,

                                ),


                              ),

                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top11==0 ? height*0.7/2 : top11,
                                          left: left11==0 ? width*0.5 : left11,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top11 = dd.localPosition.dy-height*0.1/2;
                                      left11 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )

                              ,


                            ],
                          ):
                          selected==6?
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  margin: EdgeInsets.only(top: height*0.055,left: width*0.05),
                                  height: height*0.33,
                                  width: width*0.57,

                                ),


                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top12==0 ? height*0.75/2 : top12,
                                          left: left12==0 ? width*0.1 : left12,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top12 = dd.localPosition.dy-height*0.1/2;
                                      left12 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )


                              ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==7?
                          Stack(
                            alignment: Alignment.center,
                            children: [

                            Container(
                            width: width,
                            height: height*0.55,
                            alignment: Alignment.center,
                            child: GestureDetector(
                              child: Stack(
                                children: [
                                  Positioned(
                                      top:  top13==0?  (height*0.12)/2 : top13,
                                      left: left13==0? (width*0.4)/2 : left13,
                                      child:  Container(
                                        margin: EdgeInsets.only(bottom: height*0),
                                        height: height*0.3,
                                        width: height*0.3,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(400),
                                            image: DecorationImage(
                                                image: FileImage(widget.file,),
                                                fit: BoxFit.fill
                                            )
                                        ),
                                        // child: Image.file(widget.file,fit: BoxFit.fill,)
                                      ))
                                ],
                              ),
                              onVerticalDragUpdate: (DragUpdateDetails dd){
                                setState(() {
                                  top13 = dd.localPosition.dy-height*0.3*0.5;
                                  left13 = dd.localPosition.dx-height*0.3*0.5;
                                });
                              },
                            ),

                          ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top14==0 ? height*0.8/2 : top14,
                                          left: left14==0 ? 0 : left14,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top14 = dd.localPosition.dy-height*0.1/2;
                                      left14 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )



                             ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==8?
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      )
                                  ),
                                  margin: EdgeInsets.only(top: height*0.055,left: width*0.07),
                                  height: height*0.4,
                                  width: width*0.5,

                                ),


                              ),


                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top15==0 ? height*0.8/2 : top15,
                                          left: left15==0 ? width*0.1 : left15,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top15 = dd.localPosition.dy-height*0.1/2;
                                      left15 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )



                             ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==9?
                          Stack(
                            alignment: Alignment.center,
                            children: [


                              Container(
                                width: width,
                                height: height*0.55,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top16==0?  (height*0.12)/2 : top16,
                                          left: left16==0? (width*0.4)/2 : left16,
                                          child:  Container(
                                            margin: EdgeInsets.only(bottom: height*0),
                                            height: height*0.3,
                                            width: height*0.3,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(400),
                                                image: DecorationImage(
                                                    image: FileImage(widget.file,),
                                                    fit: BoxFit.fill
                                                )
                                            ),
                                            // child: Image.file(widget.file,fit: BoxFit.fill,)
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top16 = dd.localPosition.dy-height*0.3*0.5;
                                      left16 = dd.localPosition.dx-height*0.3*0.5;
                                    });
                                  },
                                ),

                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top17==0 ? height*0.8/2 : top17,
                                          left: left17==0 ? 0 : left17,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top17 = dd.localPosition.dy-height*0.1/2;
                                      left17 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )




                              ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/GoldAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==10?
                          Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                    border: Border.all(color: Colors.black,width: 10)
                                  ),
                                  margin: EdgeInsets.only(top: height*0.07,left: width*0.2),
                                  height: width*0.5,
                                  width: width*0.7,

                                ),


                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top18==0 ? height*0.8/2 : top18,
                                          left: left18==0 ? width*0.45 : left18,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top18 = dd.localPosition.dy-height*0.1/2;
                                      left18 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )


                              ,

                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/PlatinumAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==11?
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top24==0 ? height*0.1/2 : top24,
                                          left:  left24==0 ? height*0.3/2 : left24,
                                          child:  Container(
                                            height: height*0.3,
                                            width: height*0.3,
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 10,
                                                        color: Colors.white
                                                    )
                                                  ],
                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file
                                                      ),
                                                      fit: BoxFit.fill
                                                  )
                                              ),
                                              // margin: EdgeInsets.only(left: height*0.07),
                                              height: height*0.3,
                                              width: height*0.3,
                                            ),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top24 = dd.localPosition.dy-height*0.3/2;
                                      left24 = dd.localPosition.dx-height*0.3/2;
                                    });
                                  },
                                ),

                              ),

                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top20==0 ? height*0.8/2 : top20,
                                          left: left20==0 ? width*0.45 : left20,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top20 = dd.localPosition.dy-height*0.1/2;
                                      left20 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )
                              ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/PlatinumAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==12?
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                    border: Border.all(color: Color(0xff8a7353),width: 10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Color(0xff8a7353),
                                        blurRadius: 10
                                      )
                                    ]

                                  ),
                                  margin: EdgeInsets.only(top: height*0.04,left: width*0.1),
                                  height: width*0.6,
                                  width: width*0.6,

                                ),


                              ),


                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.5,
                                  width: width*0.5,
                                  child: Image.asset("graphic_res/PlatinumAmbassador.png"),
                                ),
                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top19==0 ? height*0.8/2 : top19,
                                          left: left19==0 ? width*0.1 : left19,
                                          child:  Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(bottom: height*0.05),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top19 = dd.localPosition.dy-height*0.1/2;
                                      left19 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )
                              ,


                            ],
                          ):
                          selected==13?
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                  // margin: EdgeInsets.only(top: height*0.04,left: width*0.1),
                                  height: width*0.55,
                                  width: width*0.55,

                                ),


                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top==0 ? height*0.03 : top,
                                          left: left==0 ? width*0.1 : left,
                                          child: Container(
                                            alignment: Alignment.center,
                                                height: height*0.05,
                                                width: width*0.8,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff21554d),
                                                  border: Border.all(color: Colors.orangeAccent,width: 3),
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      offset: Offset(0,0),
                                                      blurRadius: 10,
                                                      color: Colors.orangeAccent
                                                    )
                                                  ]
                                                ),

                                              child: Text(widget.recognition_name,style: _textStyle,)))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top = dd.localPosition.dy-height*0.05/2;
                                      left = dd.localPosition.dx-width*0.8/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomCenter,
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2000),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.yellow,
                                      )
                                    ]
                                  ),
                                  child: Image.asset("graphic_res/VipPlatinumAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==14?
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                  // margin: EdgeInsets.only(top: height*0.04,left: width*0.1),
                                  height: width*0.55,
                                  width: width*0.55,

                                ),


                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top1==0 ? height*0.05 : top1,
                                          left: left1==0 ? width*0.25 : left1,
                                          child: Container(
                                              alignment: Alignment.center,
                                               height: height*0.05,
                                              width: width*0.5,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  border: Border.all(color: Colors.white,width: 3),
                                                  borderRadius: BorderRadius.circular(20),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        offset: Offset(0,0),
                                                        blurRadius: 10,
                                                        color: Colors.white
                                                    )
                                                  ]
                                              ),

                                              child: Text(widget.recognition_name,style:_textStyle,textAlign: TextAlign.center,)))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top1 = dd.localPosition.dy-height*0.05/2;
                                      left1 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.yellow,
                                        )
                                      ]
                                  ),
                                  child: Image.asset("graphic_res/VipPlatinumAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==15?
                          Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                  // margin: EdgeInsets.only(top: height*0.04,left: width*0.1),
                                  height: width*0.55,
                                  width: width*0.55,

                                ),


                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top1==0 ? height*0.45 : top1,
                                          left: left1==0 ? width*0.3 : left1,
                                          child: Container(
                                            width: width*0.5,
                                            child: Text(widget.recognition_name,style:_textStyle,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top1 = dd.localPosition.dy-height*0.1/2;
                                      left1 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2000),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Colors.yellow,
                                        )
                                      ]
                                  ),
                                  child: Image.asset("graphic_res/VipPlatinumAmbassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==16?
                          Stack(
                            // alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                   margin: EdgeInsets.only(top: height*0.07,right: width*0.1),
                                  height: width*0.55,
                                  width: width*0.55,

                                ),
                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top21==0 ? height*0.7/2 : top21,
                                          left: left21==0 ? width*0.2/2 : left21,
                                          child:   Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: height*0.03),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top21 = dd.localPosition.dy-height*0.1/2;
                                      left21 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,

                                  child: Image.asset("graphic_res/ElitePlatinumAmassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==17?
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                  margin: EdgeInsets.only(top: height*0.07,right: width*0.05),
                                  height: width*0.55,
                                  width: width*0.55,

                                ),


                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top22==0 ? height*0.7/2 : top22,
                                          left: left22==0 ? width*0.7/2 : left22,
                                          child:   Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: height*0.03),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top22 = dd.localPosition.dy-height*0.1/2;
                                      left22 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              ),
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,

                                  child: Image.asset("graphic_res/ElitePlatinumAmassador.png"),
                                ),
                              )


                            ],
                          ):
                          selected==18?
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(2000),
                                      image: DecorationImage(
                                          image: FileImage(
                                              widget.file
                                          ),
                                          fit: BoxFit.fill
                                      ),
                                      // border: Border.all(color: Colors.red,width: 10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.orangeAccent,
                                            blurRadius: 10
                                        )
                                      ]

                                  ),
                                  margin: EdgeInsets.only(top: height*0.1,right: width*0.05),
                                  height: width*0.4,
                                  width: width*0.8,

                                ),


                              ),
                              Container(
                                width: width,
                                height: height*0.55,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                          top:  top25==0 ? height*0.8/2 : top25,
                                          left: left25==0 ? width*0.5/2 : left25,
                                          child:   Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only(top: height*0.03),
                                            height: height*0.1,
                                            width: width*0.5,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            child: Text(widget.recognition_name,style:  _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                          ))
                                    ],
                                  ),
                                  onVerticalDragUpdate: (DragUpdateDetails dd){
                                    setState(() {
                                      top25 = dd.localPosition.dy-height*0.1/2;
                                      left25 = dd.localPosition.dx-width*0.5/2;
                                    });
                                  },
                                ),

                              )

                              ,
                              Container(
                                height: height*0.55,
                                width: width,
                                alignment: Alignment.topRight,
                                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 0),
                                child: Container(
                                  height: width*0.35,
                                  width: width*0.35,

                                  child: Image.asset("graphic_res/ElitePlatinumAmassador.png"),
                                ),
                              )


                            ],
                          ):

                          Container()



                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              height: AppBar().preferredSize.height,
              decoration: BoxDecoration(
                  color: RoyalOrange,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 5,
                        color: Colors.white
                    )
                  ]
              ),
              child: SizedBox(
                height: 50,
                child:ListView(
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
