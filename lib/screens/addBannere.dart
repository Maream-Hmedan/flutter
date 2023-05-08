import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../providers/banner_prov.dart';
import 'addImage_screen.dart';
import 'adminBanner_Screen.dart';

class AddBannerScreen extends StatefulWidget {
  const AddBannerScreen({Key? key}) : super(key: key);

  @override
  State<AddBannerScreen> createState() => _AddBannerState();
}

class _AddBannerState extends State<AddBannerScreen> {
  var width;
  var height;

  TextEditingController _url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Select Image"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<BannerProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<BannerProv>(context, listen: false).
                              getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.browse_gallery),
                          ),
                        ],
                      );
                    });
              },
              child: Container(
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
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _url,
              decoration: InputDecoration(
                label: const Text(" Image URL"),
                hintText: "ADD URL",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 270,
            ),
            CustButton(
              buttonText: "Save",
              onTap: () async {
                await Provider.of<BannerProv>(context, listen: false)
                    .addNewBanner( url: _url.text);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }


}
