import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/my_screens/world_team_frame.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/names.dart';
import '../constants/styles.dart';

class WorldTeamFormScreen extends StatefulWidget {
  final File file1;

  const WorldTeamFormScreen({Key? key,required this.file1}) : super(key: key);

  @override
  _WorldTeamFormScreenState createState() => _WorldTeamFormScreenState();
}

class _WorldTeamFormScreenState extends State<WorldTeamFormScreen> {

  File? _image;
  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedImage!.path);
    });
  }

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // isExtended: true,
        label: Text(
          "   Next   ",
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: RoyalOrange,
        onPressed: () {
          if(nameController.text.isEmpty){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Enter Name'),
              ),
            );
          }
          // else if(_image==null){
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text('Choose Image'),
          //     ),
          //   );
          // }
          else{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                WorldTeamFrameScreen(recognition_name: nameController.text, file: widget.file1,)));
          }


        },
      ),




      appBar: AppBar(
        backgroundColor: RoyalOrange,
        centerTitle: true,
        title: Text("World Team Form",
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
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: height*0.05,
                  width: width,
                  child: InkWell(
                    onTap: (){
                      choiceImage();
                    },
                    child: Text("Upload Image",style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),),
                  ),
                ),
                InkWell(
                  onTap: (){
                    choiceImage();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                    height: width-10,
                    width: width-10,
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
                    child: Image.file(widget.file1,fit: BoxFit.fill,),
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: width,
                  height: height*0.12,
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
              ],
            ),

          ),
        ),
      ),
    );
  }
}
