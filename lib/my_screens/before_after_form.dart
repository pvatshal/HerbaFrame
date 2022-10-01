import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/my_screens/ambassador_frame.dart';
import 'package:image_editor_tutorial/my_screens/before_after_frame.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/names.dart';
import '../constants/styles.dart';

class BeforeAfterFormScreen extends StatefulWidget {

  final File file1;
  final File file2;
  const BeforeAfterFormScreen({Key? key, required this.file1, required this.file2}) : super(key: key);

  @override
  _BeforeAfterFormScreenState createState() => _BeforeAfterFormScreenState();
}

class _BeforeAfterFormScreenState extends State<BeforeAfterFormScreen> {
  String dropdownValue = '';

  File? _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  File? _image1;
  final picker1 = ImagePicker();

  Future choiceImage1() async {
    var pickedImage1 = await picker1.pickImage(source: ImageSource.gallery);
    setState(() {
      _image1 = File(pickedImage1!.path);
    });
  }




  TextEditingController nameController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height-AppBar().preferredSize.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // isExtended: true,
        label: Text(
          "   Next   ",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600
          ),
        ),
        backgroundColor: RoyalOrange,
        onPressed: () {
          if(nameController.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Enter Name'),
              ),
            );
          }else if(dropdownValue==""){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Select a Reason'),
              ),
            );
          }
          else{
            if((dropdownValue=="Weight Loss" || dropdownValue=="Weight Gain") && weightController.text.isEmpty ){

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enter Weight'),
                  ),
                );
            }


            String text1 = '';
            if(dropdownValue=="Weight Loss" || dropdownValue=="Weight Gain"){
              text1 = weightController.text +" Kg " + dropdownValue;
            }else{
              text1 = dropdownValue;
            }

            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                BeforeAfterFrameScreen(
                  recognition_name: nameController.text,
                  file: widget.file1,
                  file1: widget.file2,
                  weight: text1,)));
          }
        },
      ),




      appBar: AppBar(
        backgroundColor: RoyalOrange,
        centerTitle: true,
        title: Text("Before After Form",
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

      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: RoyalBlue,
            height: height+height*0.5,
            width: width,
            child: Column(
              children: [
                Container(
                 height: height*0.4,
                 width: width,
                 child: Row(
                   children: [
                     Container(
                       width: width*0.5,
                       child: Column(
                         children: [
                           Container(

                             alignment: Alignment.center,
                             padding: EdgeInsets.symmetric(horizontal: 20),
                             height: height*0.08,
                             width: width*0.5,
                             child: InkWell(
                               onTap: (){
                                 // choiceImage();
                               },
                               child: Text("Uploaded Before Image",style: GoogleFonts.poppins(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                             ),
                           ),
                           Container(
                             margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                             height: width*0.5-10,
                             width: width*0.5-10,
                             decoration: BoxDecoration(
                                 color: Colors.white70,
                                 borderRadius: BorderRadius.circular(20),
                                 boxShadow: [
                                   BoxShadow(
                                       color: Colors.white70,
                                       offset: Offset(0,0),
                                       blurRadius: 10
                                   )
                                 ]
                             ),
                             child: Image.file(widget.file1),
                           ),
                         ],
                       ),
                     ),
                     Container(
                       width: width*0.5,
                       child: Column(
                         children: [
                           Container(
                             alignment: Alignment.center,
                             padding: EdgeInsets.symmetric(horizontal: 20),
                             height: height*0.08,
                             width: width*0.5,
                             child: InkWell(
                               onTap: (){
                                 // choiceImage1();
                               },
                               child: Text("Uploaded After Image",style: GoogleFonts.poppins(
                                   color: Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.w600),textAlign: TextAlign.center,),
                             ),
                           ),
                           InkWell(
                             onTap: (){
                               // choiceImage();
                             },
                             child: Container(
                               margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                               height: width*0.5-10,
                               width: width*0.5-10,
                               decoration: BoxDecoration(
                                   color: Colors.white70,
                                   borderRadius: BorderRadius.circular(20),
                                   boxShadow: [
                                     BoxShadow(
                                         color: Colors.white70,
                                         offset: Offset(0,0),
                                         blurRadius: 10
                                     )
                                   ]
                               ),
                               child:  Image.file(widget.file2),
                             ),
                           ),
                         ],
                       ),
                     ),
                   ],
                 ),
               ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  height: height*0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: height*0.03,
                        child: Text(name_text,style:  GoogleFonts.poppins(
                            color: RoyalOrange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        height: height*0.07,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: LightOrange,
                            border: OutlineInputBorder(),
                            hintText: "Enter Name",
                            hintStyle: TextStyle(
                                color: RoyalBlue,
                                fontSize: 14
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  decoration: BoxDecoration(
                      color: LightOrange,
                      shape: BoxShape.rectangle,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 0,
                      dropdownColor: LightOrange,
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      style: const TextStyle(color: Colors.black),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['','Weight Gain',
                        'Weight Loss',
                        'Amazing Transformation',
                        'Amazing Skin Result',
                        'Skin Improvement',
                        'Engergy Improvement'
                      ]
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                dropdownValue == "Weight Gain" ?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  height: height*0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: height*0.03,
                        child: Text("How many Kg",style:  GoogleFonts.poppins(
                            color: RoyalOrange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        height: height*0.07,
                        child: TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: LightOrange,
                            border: OutlineInputBorder(),
                            hintText: "Enter Kg",
                            hintStyle: TextStyle(
                                color: RoyalBlue,
                                fontSize: 14
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ) :
                dropdownValue == "Weight Loss" ?
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  height: height*0.1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.bottomLeft,
                        height: height*0.03,
                        child: Text("How many Kg",style:  GoogleFonts.poppins(
                            color: RoyalOrange,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),),
                      ),
                      Container(
                        height: height*0.07,
                        child: TextFormField(
                          controller: weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: LightOrange,
                            border: OutlineInputBorder(),
                            hintText: "Enter Kg",
                            hintStyle: TextStyle(
                                color: RoyalBlue,
                                fontSize: 14
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: LightOrange),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),




                    ],
                  ),
                ) :
                    Container()
                ,

              ],
            ),

          ),
        ),
      ),
    );
  }
}
