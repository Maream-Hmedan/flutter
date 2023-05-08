import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../custButton.dart';
import '../providers/banner_prov.dart';
import 'editShop.dart';

class addImage extends StatefulWidget {
  const addImage({Key? key}) : super(key: key);

  @override
  State<addImage> createState() => _addImageState();
}

class _addImageState extends State<addImage> {
  var width;
  var height;

  File ? image =null;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: width,
              height: height * .2,
              child: Consumer<BannerProv>(
                builder: (context, value, child) {
                  return value.image != null
                      ? Image.file(
                    value.  image!,
                    width: width,
                    height: height * 0.2,
                    fit: BoxFit.fill,
                  )
                      : const Icon(
                    (Icons.image),
                  );
                },
              ),
            ),
            Row(
              children: [
                IconButton(onPressed: (){
                  Provider.of<BannerProv>(context, listen: false).
                  getImage(ImageSource.camera);

                }, icon: const Icon(Icons.camera_alt)),
                const SizedBox(width: 20,),
                IconButton(onPressed: (){
                  Provider.of<BannerProv>(context, listen: false).
                  getImage(ImageSource.gallery);
                }, icon: const Icon(Icons.image_rounded)),
              ],
            ),
            const SizedBox(height: 400,),
            CustButton(buttonText: "Save",onTap: (){
              Navigator.pop(context);

            }),

          ],
        ),
      ),
    );

  }
}
