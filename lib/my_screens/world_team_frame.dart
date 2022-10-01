import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_font_picker/flutter_font_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:pinch_zoom/pinch_zoom.dart';
import 'package:screenshot/screenshot.dart';

import '../constants/styles.dart';
import '../utils/utils.dart';
import 'dart:ui' as ui;
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
class WorldTeamFrameScreen extends StatefulWidget {

  final File file;
  final String recognition_name;

  const WorldTeamFrameScreen({Key? key,required this.file,required this.recognition_name}) : super(key: key);

  @override
  _WorldTeamFrameScreenState createState() => _WorldTeamFrameScreenState();
}

class _WorldTeamFrameScreenState extends State<WorldTeamFrameScreen> {

  Color? selectedColor = Colors.white;
  double size = 16;


  ScreenshotController screenshotController = ScreenshotController();

  PickerFont? _selectedFont;
  TextStyle _textStyle = GoogleFonts.poppins(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600);


  var top2 = 0.0;
  var left2 = 0.0;


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

  int w = 0;
  int h = 0;

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
        title: Text("World Team Frame",
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
                  itemCount: 4,
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
                            return "graphic_res/recognition02.png";
                          }else if(index==1){
                            return "graphic_res/recognition03.png";
                          }else if(index==2){
                            return "graphic_res/recognition04.png";
                          }else if(index==3){
                            return "graphic_res/recognition05.png";
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
                              return "graphic_res/recognition02.png";
                            }else if(selected==1){
                              return "graphic_res/recognition03.png";
                            }else if(selected==2){
                              return "graphic_res/recognition04.png";
                            }else if(selected==3){
                              return "graphic_res/recognition05.png";
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
                                  margin: EdgeInsets.only(bottom: height*0),
                                  color: Colors.red,
                                    height: height*0.215,
                                    width: height*0.215,
                                    child: Image.file(widget.file,fit: BoxFit.fill,)),
                                Container(
                                  width: width,
                                  height: height*0.55,
                                  child: GestureDetector(
                                    child: Stack(
                                      children: [
                                        Positioned(
                                            top:  top2==0 ? 5.0 : top2,
                                            left: left2==0 ? width*0.4 : left2,
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
                                        top2 = dd.localPosition.dy-50;
                                        left2 = dd.localPosition.dx-50;
                                      });
                                    },
                                  ),

                                ),


                              ],
                            ),
                          )
                              :
                              selected==1?
                              Stack(
                                children: [
                                  Container(
                                    height: height*0.55,
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                        ),
                                        margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                        height: height*0.25,
                                        width: height*0.25,
                                      child: CircularText(
                                        children: [
                                          TextItem(
                                            text: Text(
                                              widget.recognition_name.toUpperCase(),
                                              style: _textStyle,
                                            ),
                                            space: 10,
                                            startAngle: 90,
                                            startAngleAlignment: StartAngleAlignment.center,
                                            direction: CircularTextDirection.anticlockwise,
                                          ),
                                        ],
                                        radius: 125,
                                        position: CircularTextPosition.inside,
                                      ),

                                    ),


                                  ),
                                  // Container(
                                  //   height: height*0.55,
                                  //   width: width,
                                  //   alignment: Alignment.center,
                                  //   child: Container(
                                  //     decoration: BoxDecoration(
                                  //
                                  //         // borderRadius: BorderRadius.circular(200),
                                  //             color: Colors.orangeAccent,
                                  //       shape: BoxShape.circle,
                                  //             // image: DecorationImage(
                                  //             //   image:
                                  //             // )
                                  //
                                  //
                                  //
                                  //             // FileImage(
                                  //             //     widget.file
                                  //             // )
                                  //
                                  //     ),
                                  //     margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                  //     height: height*0.2,
                                  //     width: height*0.2,
                                  //     alignment: Alignment.center,
                                  //     // child: PinchZoom(
                                  //     //   child:CircleAvatar(
                                  //     //     backgroundImage: FileImage(widget.file),
                                  //     //   ),
                                  //     // ),
                                  //     // child: PhotoView(
                                  //     //   enableRotation: true,
                                  //     //   imageProvider: ,
                                  //     // ),
                                  //     child: InteractiveViewer(
                                  //       panEnabled: false, // Set it to false
                                  //       // boundaryMargin: EdgeInsets.all(11100),
                                  //
                                  //       child: Image.file(
                                  //        widget.file,
                                  //         fit: BoxFit.contain,
                                  //       ),
                                  //     ),
                                  //
                                  //   ),
                                  //
                                  //
                                  // ),
                                  Container(
                                    height: height*0.55,
                                    width: width,
                                    alignment: Alignment.center,
                                    child: Container(
                                      decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(200),

                                          image: DecorationImage(
                                              image: FileImage(
                                                  widget.file
                                              )
                                          )
                                      ),
                                      margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                      height: height*0.2,
                                      width: height*0.2,

                                    ),


                                  )
                                ],
                              ) :
                                  selected==2?
                                  Stack(
                                    children: [
                                      Container(
                                        height: height*0.55,
                                        width: width,
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(200),
                                          ),
                                          margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                          height: height*0.25,
                                          width: height*0.25,
                                          child: CircularText(
                                            children: [
                                              TextItem(
                                                text: Text(
                                                  widget.recognition_name.toUpperCase(),
                                                  style: _textStyle,
                                                ),
                                                space: 10,
                                                startAngle: 90,
                                                startAngleAlignment: StartAngleAlignment.center,
                                                direction: CircularTextDirection.anticlockwise,
                                              ),
                                            ],
                                            radius: 125,
                                            position: CircularTextPosition.inside,
                                          ),

                                        ),


                                      ),
                                      Container(
                                        height: height*0.55,
                                        width: width,
                                        alignment: Alignment.center,
                                        child: Container(
                                          decoration: BoxDecoration(

                                              borderRadius: BorderRadius.circular(200),

                                              image: DecorationImage(
                                                  image: FileImage(
                                                      widget.file
                                                  )
                                              )
                                          ),
                                          margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                          height: height*0.2,
                                          width: height*0.2,

                                        ),


                                      ),

                                    ],
                                  ):
                                      selected==3?
                                      Stack(
                                        children: [
                                          Container(
                                            height: height*0.55,
                                            width: width,
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(200),
                                              ),
                                              margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                              height: height*0.25,
                                              width: height*0.25,
                                              child: CircularText(
                                                children: [
                                                  TextItem(
                                                    text: Text(
                                                      widget.recognition_name.toUpperCase(),
                                                      style: _textStyle,
                                                    ),
                                                    space: 10,
                                                    startAngle: 90,
                                                    startAngleAlignment: StartAngleAlignment.center,
                                                    direction: CircularTextDirection.anticlockwise,
                                                  ),
                                                ],
                                                radius: 125,
                                                position: CircularTextPosition.inside,
                                              ),

                                            ),
                                          ),
                                          Container(
                                            height: height*0.55,
                                            width: width,
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(200),

                                                  image: DecorationImage(
                                                      image: FileImage(
                                                          widget.file
                                                      )
                                                  )
                                              ),
                                              margin: EdgeInsets.only(bottom: height*0.125,right: width*0.1),
                                              height: height*0.2,
                                              width: height*0.2,

                                            ),


                                          ),

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
