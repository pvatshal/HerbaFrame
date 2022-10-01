import 'package:flutter/material.dart';
import 'package:image_editor_tutorial/screens/add_image.dart';
import 'package:image_editor_tutorial/screens/edit_image_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(
                Icons.save,
              ),
              onPressed: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddImageScreen(
                      ),
                    ),
                  );

              },
            ),


            IconButton(
              icon: const Icon(
                Icons.upload_file,
              ),
              onPressed: () async {
                XFile? file = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (file != null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EditImageScreen(
                        selectedImage: file.path,
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
