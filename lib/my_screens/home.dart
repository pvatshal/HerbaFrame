import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/models/category_model.dart';
import 'package:image_editor_tutorial/models/images.dart';
import 'package:image_editor_tutorial/my_screens/active_superviser_form.dart';
import 'package:image_editor_tutorial/my_screens/ambassador_form.dart';
import 'package:image_editor_tutorial/my_screens/before_after_form.dart';
import 'package:image_editor_tutorial/my_screens/edit_frame.dart';
import 'package:image_editor_tutorial/my_screens/edit_frame_temp.dart';
import 'package:image_editor_tutorial/my_screens/settings.dart';
import 'package:image_editor_tutorial/my_screens/superviser_form.dart';
import 'package:image_editor_tutorial/my_screens/world_team_form.dart';
import 'package:image_editor_tutorial/services/get_category_service.dart';
import 'package:image_editor_tutorial/services/get_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/crop_image_01.dart';
import '../screens/edit_image_screen.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }


  DateTime now = DateTime.now();

  bool isLoading = true;
  bool isLoading1 = true;

  late List<Images> list1 = [];

  late Images images;

  var category = [];
  var map = Map();

  List categoryKeys = [];
  List categoryValues = [];

  late Category category1;

  Map<String, Set> map2 = {};

  Set set1 = {};

  String name = '';


  getname() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = (prefs.getString('name') ?? 0).toString();
    });
  }


  getAllImagesHere(){
    print(now.month);
    setState(() {
      isLoading = true;
    });


    GetCategoryService.getAllCategory().then((value) {
      if(value!=null){
        print(value);
        setState(() {
          category1 = value;
          isLoading1 = false;
          print("Isloading 1"+isLoading1.toString());
        });
      }
    });

    GetImagesService.getAllImages().then((value) {
      //print(value);
      if(value!=null){
        setState(() {
          images = value;
          isLoading = false;
          print("Isloading "+isLoading.toString());

          list1.add(value);
          print("kkkk");
          print(value);
          print("kkkk");

          for(int i=0;i<value.data.length;i++){
            category.add(value.data[i].category);
            set1.add(value.data[i].category);
            print(set1);
          }


          for(int j=0;j<set1.length;j++){
            Set set11 = {};
            for(int i=0;i<images.data.length;i++){
              if(set1.elementAt(j)==images.data[i].category){
                set11.add(images.data[i].subCategory);
              }
            }
            map2.putIfAbsent(set1.elementAt(j), () => set11);
          }



          category.forEach((element) {
            if(!map.containsKey(element)) {
              map[element] = 1;
            } else {
              map[element] +=1;
            }
          });

          print(map);

          print(map.keys.toList().first);
          categoryKeys = map.keys.toList();
          categoryValues = map.values.toList();
          print(categoryKeys);
          print(categoryValues);
        });
      }
    });
  }





  Map<String, Set> map1 = {'one':{"heelo","jdskjksd"},'two':{"dksj","knjsdnjds"}};


  Future<bool> showExitPopup() async {
    return await showDialog( //show confirm dialogue
      //the return value will be from "Yes" or "No" options
      context: context,
      builder: (context) =>

          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
            backgroundColor: RoyalBlue.withOpacity(0.9),
            title: Text('Exit'),
            content: Text('Do you want to exit an App?',style: TextStyle(color: RoyalOrange,fontSize: 18),),
            actions:[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                //return false when click on "NO"
                child:Text('No'),
              ),

              ElevatedButton(
                onPressed: () => exit(0),
                //return true when click on "Yes"
                child:Text('Yes'),
              ),

            ],
          ),
    )??false; //if showDialouge had returned null, then return false
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secureScreen();
    getAllImagesHere();
    getname();
  }


  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(

        backgroundColor: RoyalBlue,
        appBar: AppBar(
          backgroundColor: RoyalOrange,
          centerTitle: true,
          title: Text("Home",
            style: GoogleFonts.poppins(
                color: RoyalBlue,
                fontSize: 20,
                fontWeight: FontWeight.w600),),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
              },
              icon: Icon(FontAwesomeIcons.sun,color: Colors.white,size: 20,),
            )
          ],


        ),

        body: Container(
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  height: height*0.1,
                  child: Text("Good Morning,\n"+name,style: GoogleFonts.poppins(
                      color:RoyalOrange,
                      fontSize: 24,
                      fontWeight: FontWeight.w500),),

                ),

                Container(
                  height: 300,
                  width: width,
                  child: Column(
                    children: [
                      Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.bottomLeft,
                          child: Text("Appreciation",style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),)
                      ),

                      isLoading ==false?

                      Container(
                        height: 250,
                        child: ListView.builder(
                            itemCount: 5,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 90,
                                width: 250,
                                padding: EdgeInsets.all(10),
                                child: InkWell(
                                  onTap: (){
                                    if(index==0){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("World Team")));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldTeamFormScreen()));
                                    }else if(index==1){
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("Active Supervisor")));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>BeforeAfterFormScreen()));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("Before After")));
                                    }else if(index==2){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("Ambassador")));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AmbassadorFormScreen()));
                                    }else if(index==3){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("Supervisor")));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>SuperviserFormScreen()));
                                    }else if(index==4){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImageScreen("Active Supervisor")));
                                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ActiveSuperviserFormScreen()));
                                    }




                                    // Navigator.of(context).push(
                                    //   MaterialPageRoute(
                                    //     builder: (context) => EditFrameTempScreen(images1: [],),
                                    //   ),
                                    // );
                                  },
                                  child: Container(
                                    height: 80,

                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: RoyalOrange,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white70,
                                            offset: Offset(
                                              0.0,
                                              0.0,
                                            ),
                                            blurRadius: 10.0,
                                          ),
                                        ]
                                    ),
                                    child: Text(
                                      (){
                                        if(index==0){
                                          return "World Team";
                                        }else if(index==1){
                                          return "Before Afrer";
                                        }else if(index==2){
                                          return "Ambassador";
                                        }else if(index==3){
                                          return "Superviser";
                                        }else if(index==4){
                                          return "Active Superviser";
                                        }
                                        else{
                                          return "";
                                        }
                                      }()

                                     ,style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),),
                                    // child: Image.asset("graphic_res/goodmoring.jpeg"),
                                  ),
                                ),
                              );
                            }),
                      )
                          :
                      Container()
                    ],
                  ),
                ),

                isLoading1==false?
                Container(
                  height: (350 * double.parse(map2.length.toString())),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: category1.data.length,
                      itemBuilder: (context, index) {
                    return Container(
                      height: 350,
                      width: width,
                      child: Column(
                        children: [
                          Container(
                              height: 50,
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.bottomLeft,
                              child: Text(category1.data[index].name,style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),)
                          ),

                          isLoading ==false?

                          Container(
                            height: 300,
                            child: ListView.builder(
                                itemCount: map2[category1.data[index].name]!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, i) {
                                  return
                                    Column(
                                      children: [
                                        Container(
                                        height: 250,
                                        width: 250,
                                        padding: EdgeInsets.all(10),
                                        child: InkWell(
                                          onTap: (){

                                            print(map2[category1.data[index].name]!.elementAt(i));

                                            List<String> list11 = [];


                                            for(int j=0;j<images.data.length;j++){
                                                if(map2[category1.data[index].name]!.elementAt(i)==images.data[j].subCategory){
                                                  list11.add(images.data[j].image);
                                                }
                                            }
                                            print(list11);


                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => EditFrameTempScreen(images1: list11,),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(
                                                      images.data[images.data.indexWhere((element) => element.subCategory==map2[category1.data[index].name]!.elementAt(i))].image),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black,
                                                    offset: Offset(
                                                      0.0,
                                                      1.0,
                                                    ),
                                                    blurRadius: 3.0,
                                                  ),
                                                ]


                                            ),

                                            // child: Image.asset("graphic_res/goodmoring.jpeg"),
                                          ),
                                        ),
                                  ),
                                        Container(
                                          alignment: Alignment.topCenter,
                                            height: 50,
                                            child: Text(map2[category1.data[index].name]!.elementAt(i),style:  GoogleFonts.poppins(
                                                color: RoyalOrange,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),))
                                      ],
                                    );
                                }),
                          )
                              :
                          Container()
                        ],
                      ),
                    );
                  }),
                ):Container(),






              ],
            ),
          ),
        ),


      ),
    );
  }
}
