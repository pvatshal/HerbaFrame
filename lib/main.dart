import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/my_screens/home.dart';
import 'package:image_editor_tutorial/my_screens/register.dart';
import 'package:image_editor_tutorial/my_screens/splash.dart';
import 'package:image_editor_tutorial/my_screens/welcome.dart';
import 'package:image_editor_tutorial/screens/crop_image_01.dart';
import 'package:image_editor_tutorial/screens/home_screen.dart';
import 'package:image_editor_tutorial/screens/temp.dart';
import 'package:image_editor_tutorial/screens/temp01.dart';

import 'my_screens/edit_frame_temp.dart';
import 'my_screens/loading_screen.dart';

// harbaframe
// com.harbaframe.app

void main() {
  runApp(const MyyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Image Editor',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class MyyApp extends StatefulWidget {
  const MyyApp({Key? key}) : super(key: key);

  @override
  _MyyAppState createState() => _MyyAppState();
}

class _MyyAppState extends State<MyyApp> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: CropImageScreen(),
      home: SplashScreen(),
    );
  }
}

