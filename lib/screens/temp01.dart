import 'package:flutter/material.dart';

import '../models/text_info.dart';
import '../widgets/image_text.dart';

class DragWidgetScreen extends StatefulWidget {
  const DragWidgetScreen({Key? key}) : super(key: key);

  @override
  _DragWidgetScreenState createState() => _DragWidgetScreenState();
}

class _DragWidgetScreenState extends State<DragWidgetScreen> {

  var top = 0.0;
  var left = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 100,vertical: 100),
        color: Colors.redAccent,
        height: 400,
        width: 200,
        child: GestureDetector(
            child: Stack(
              children: [
                Positioned(
                    top: top,
                    left: left,
                    child: Image.asset("graphic_res/logo_temp.png"),height: 100,width: 100,),
              ],
            ),
          onVerticalDragUpdate: (DragUpdateDetails dd){
              setState(() {
                top = dd.localPosition.dy-96;
                print(top);
                left = dd.localPosition.dx-96;
              });
          },
        ),
      ),
    );
  }}
