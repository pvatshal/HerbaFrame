import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:o_color_picker/o_color_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/names.dart';
import '../constants/styles.dart';
import '../utils/utils.dart';

import 'dart:ui' as ui;
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class SuperviserFrameScreen extends StatefulWidget {

  final File file;
  final String recognition_name;

  const SuperviserFrameScreen({Key? key,required this.file,required this.recognition_name}) : super(key: key);

  @override
  _SuperviserFrameScreenState createState() => _SuperviserFrameScreenState();
}

class _SuperviserFrameScreenState extends State<SuperviserFrameScreen> {

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
        title: Text("Superviser Frame",
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
                  itemCount: 3,
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
                                  return "graphic_res/supervisor01.png";
                                }else if(index==1){
                                  return "graphic_res/supervisor02.png";
                                }else if(index==2){
                                  return "graphic_res/supervisor03.png";
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
                              return "graphic_res/supervisor01.png";
                            }else if(selected==1){
                              return "graphic_res/supervisor02.png";
                            }else if(selected==2){
                              return "graphic_res/supervisor03.png";
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
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top:  top3==0 ? height*0.05 : top3,
                                            left: left3==0? (height*0.3*0.5 - height*0.3*0.5*0.25) : left3,
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
                                        top3 = dd.localPosition.dy-height*0.3/2;
                                        left3 = dd.localPosition.dx-height*0.3/2;
                                      });
                                    },
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
                                            top:  top4==0 ? height*0.4 : top4,
                                            left: left4==0 ? width*0.2 : left4,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(left: width*0.1),
                                              height: height*0.1,
                                              width: width*0.4,

                                              child: Text(widget.recognition_name,style: _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top4 = dd.localPosition.dy-height*0.1/2;
                                        left4 = dd.localPosition.dx-width*0.4/2;
                                      });
                                    },
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
                                            top:  top10==0 ? height*0 : top10,
                                            left: left10==0 ? width*0.1 : left10,
                                            child: Container(
                                              height: width*0.3,
                                              width:width*0.3,
                                              alignment: Alignment.bottomRight,
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Container(
                                                height: width*0.3,
                                                width: width*0.3,
                                                child: Image.asset("graphic_res/superviser.png"),
                                              ),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top10 = dd.localPosition.dy-width*0.3/2;
                                        left10 = dd.localPosition.dx-width*0.3/2;
                                      });
                                    },
                                  ),

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

                                Container(
                                  width: width,
                                  height: height*0.55,
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top:  top3==0 ? (height*0.3*0.5 - height*0.3*0.25) : top3,
                                            left: left3==0? (height*0.3*0.5 - height*0.3*0.5*0.25) : left3,
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
                                        top3 = dd.localPosition.dy-height*0.3/2;
                                        left3 = dd.localPosition.dx-height*0.3/2;
                                      });
                                    },
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
                                            top:  top4==0 ? height*0.35 : top4,
                                            left: left4==0 ? width*0.2 : left4,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(left: width*0.1),
                                              height: height*0.1,
                                              width: width*0.4,

                                              child: Text(widget.recognition_name,style: _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top4 = dd.localPosition.dy-height*0.1/2;
                                        left4 = dd.localPosition.dx-width*0.4/2;
                                      });
                                    },
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
                                            top:  top10==0 ? height*0 : top10,
                                            left: left10==0 ? width*0.1 : left10,
                                            child: Container(
                                              height: width*0.3,
                                              width:width*0.3,
                                              alignment: Alignment.bottomRight,
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Container(
                                                height: width*0.3,
                                                width: width*0.3,
                                                child: Image.asset("graphic_res/superviser.png"),
                                              ),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top10 = dd.localPosition.dy-width*0.3/2;
                                        left10 = dd.localPosition.dx-width*0.3/2;
                                      });
                                    },
                                  ),

                                ),

                              ],
                            ),
                          )
                              :
                          selected==2?
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
                                      alignment: Alignment.center,
                                      children: [
                                        Positioned(
                                            top:  top22==0 ? height*0.13 : top22,
                                            left: left22==0? (height*0.3*0.5 - height*0.3*0.5*0.25) : left22,
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
                                        top22 = dd.localPosition.dy-height*0.3/2;
                                        left22 = dd.localPosition.dx-height*0.3/2;
                                      });
                                    },
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
                                            top:  top21==0 ? height*0.4 : top21,
                                            left: left21==0 ? width*0.2 : left21,
                                            child: Container(
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(left: width*0.1),
                                              height: height*0.1,
                                              width: width*0.4,

                                              child: Text(widget.recognition_name,style: _textStyle,maxLines: 3,textAlign: TextAlign.center,),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top21 = dd.localPosition.dy-height*0.1/2;
                                        left21 = dd.localPosition.dx-width*0.4/2;
                                      });
                                    },
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
                                            top:  top10==0 ? height*0.3 : top10,
                                            left: left10==0 ? width*0.6 : left10,
                                            child: Container(
                                              height: width*0.3,
                                              width:width*0.3,
                                              // alignment: Alignment.bottomRight,
                                              padding: EdgeInsets.symmetric(vertical: 20),
                                              child: Container(
                                                height: width*0.3,
                                                width: width*0.3,
                                                child: Image.asset("graphic_res/superviser.png"),
                                              ),
                                            ))
                                      ],
                                    ),
                                    onVerticalDragUpdate: (DragUpdateDetails dd){
                                      setState(() {
                                        top10 = dd.localPosition.dy-width*0.3/2;
                                        left10 = dd.localPosition.dx-width*0.3/2;
                                      });
                                    },
                                  ),

                                ),

                              ],
                            ),
                          )
                              :



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
                child: SizedBox(
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
              ),

            )


          ],
        ),

      ),

    );
  }
}
