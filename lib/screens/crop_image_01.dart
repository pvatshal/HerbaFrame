import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_editor_tutorial/constants/styles.dart';
import 'package:image_editor_tutorial/my_screens/active_superviser_form.dart';
import 'package:image_editor_tutorial/my_screens/ambassador_form.dart';
import 'package:image_editor_tutorial/my_screens/ambassador_frame.dart';
import 'package:image_editor_tutorial/my_screens/world_team_form.dart';
import 'package:image_editor_tutorial/screens/crop_image_02.dart';
import 'package:image_editor_tutorial/screens/crop_image_03.dart';
import 'package:image_picker/image_picker.dart';

import '../my_screens/superviser_form.dart';

class CropImageScreen extends StatefulWidget {

  final String screen;

  CropImageScreen(this.screen);

  @override
  _CropImageScreenState createState() => new _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;
  File? _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: RoyalBlue,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample!, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildOpenImage(),
              TextButton(
                style:  ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(RoyalOrange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: RoyalOrange),
                        )
                    )
                ),
                child: Text(
                  '       Next       ',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),

            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return

      TextButton(
        style:  ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black),
                )
            )
        ),
      child:
      widget.screen=="Before After"?
      Text(
        '       Upload Before Image       ',

        style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
      ):
      Text(
        '       Upload Image       ',

        style: Theme.of(context).textTheme.button!.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(),
    );
  }

  Future<void> _openImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    final file = File(pickedFile!.path);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size!.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState!.scale;
    final area = cropKey.currentState!.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file!,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    if(widget.screen=="Active Supervisor"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ActiveSuperviserFormScreen(file1: _lastCropped!)));
    }else if(widget.screen=="World Team"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>WorldTeamFormScreen(file1: _lastCropped!)));
    }else if(widget.screen=="Ambassador"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>AmbassadorFormScreen(file1: _lastCropped!)));
    } else if(widget.screen=="Supervisor"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>SuperviserFormScreen(file1: _lastCropped!)));
    }else if(widget.screen=="Before After"){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CropImage03Screen(_lastCropped!)));

    }



    debugPrint('$file');
  }
}