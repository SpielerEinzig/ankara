import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class LocalImages extends StatefulWidget {
  const LocalImages({Key? key}) : super(key: key);

  @override
  _LocalImagesState createState() => _LocalImagesState();
}

class _LocalImagesState extends State<LocalImages> {
  Future<Directory?>? _appDocumentsDirectory;
  XFile? image;
  // List<XFile> imageFileList = [];

  var picker = ImagePicker();

  pickImage() async {
    _appDocumentsDirectory = getApplicationDocumentsDirectory();
    final selectedImage = await picker.pickImage(source: ImageSource.gallery);

    if (selectedImage != null) {
      image = selectedImage;
      // imageFileList.addAll(selectedImage);
    }

    setState(() {});
  }

  void addimage() {}

  void _requestAppDocumentsDirectory() {
    setState(() {
      var _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  // Future saveImagesPermanently(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final names = basename(imagePath);
  //   return File(imagePath).copy(imageFileList.path);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: 10,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 6,
                  offset: Offset(6, 6), // Shadow position
                ),
              ]),
              child: Image.file(
                File(image!.path),
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple[800],
        onPressed: () {
          pickImage();
        },
        child: Center(
            child: Text(
          'Add Image',
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}
