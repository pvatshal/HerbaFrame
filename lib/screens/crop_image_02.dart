import 'dart:io';

import 'package:flutter/material.dart';

class CropImageViewScreen extends StatefulWidget {
  final File file;
  
  const CropImageViewScreen({Key? key,required this.file}) : super(key: key);

  @override
  _CropImageViewScreenState createState() => _CropImageViewScreenState();
}

class _CropImageViewScreenState extends State<CropImageViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(widget.file),
      ),
    );
  }
}
