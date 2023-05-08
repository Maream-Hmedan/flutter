import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class addImages extends StatefulWidget {
  const addImages({Key? key}) : super(key: key);

  @override
  State<addImages> createState() => _addImagesState();
}

class _addImagesState extends State<addImages> {
  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if (pickedfiles != null) {
        imagefiles = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:  Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            //open button ----------------
            ElevatedButton(
                onPressed: () {
                  openImages();
                },
                child: Text("Open Images")),
            Divider(),
            Text("Picked Files:"),
            Divider(),

            imagefiles != null
                ? Wrap(
              children: imagefiles!.map((imageone) {
                return Container(
                    child: Card(
                      child: Container(
                        height: 100,
                        width: 100,
                        child: Image.file(File(imageone.path)),
                      ),
                    ));
              }).toList(),
            )
                : Container()
          ],
        ),
      ),

    );
  }
}
