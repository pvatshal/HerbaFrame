import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/images.dart';
import '../services/get_category_service.dart';
import '../services/get_images.dart';

class TempScreen extends StatefulWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {

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
        });
      }
    });





    GetImagesService.getAllImages().then((value) {
      //print(value);
      if(value!=null){
        setState(() {
          images = value;
          isLoading = false;

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllImagesHere();
  }


  @override
  Widget build(BuildContext context) {
    double safe = MediaQuery.of(context).padding.top;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: InkWell(
                onTap: (){
                  print(map1['one']);
                  print(set1.elementAt(0));
                  print(map2);
                  print(map2["Festivals"]!.elementAt(2));
                  print(map2[category1.data[0].name]!.elementAt(1));
                  print(images.data[images.data.indexWhere((element) => element.subCategory=="Uttarayan")].image);

                },
                child: Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                ),
              ),
            ),
            Container(
              height: height*0.6,
              width: width,
              child: ListView.builder(
                  itemCount: map2.length,
                  itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(20),
                  height: 100,
                  width: width,
                  color: Colors.red,
                  child: Container(
                      height: 100,
                      width: 50,
                    color: Colors.white70,
                    margin: EdgeInsets.all(20),
                    child: ListView.builder(
                      itemCount: map2[category1.data[index].name]!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) {

                     return Container(
                       height: 100,
                       width: 50,
                       color: Colors.blue,
                       margin: EdgeInsets.all(10),
                       child: Text(map2[category1.data[index].name]!.elementAt(i),style: TextStyle(color: Colors.white),),
                     ); 
                    }),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
