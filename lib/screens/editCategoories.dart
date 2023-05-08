import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/catigores_image.dart';
import '../providers/categories_prov.dart';
import 'addImage_screen.dart';


class EditCategoriesScreen extends StatefulWidget {
  CategoriesModel categoriesModel;
  int index;

  EditCategoriesScreen({required this.categoriesModel, required this.index});

  @override
  State<EditCategoriesScreen> createState() => _EditCategoriesScreenState();
}

class _EditCategoriesScreenState extends State<EditCategoriesScreen> {
  File? image = null;
  var width;
  var height;
  TextEditingController _name = TextEditingController();
  String dropdownValue="";
  var Id_statustypes;

  @override
  void initState() {
    super.initState();
    _name.text = widget.categoriesModel.name;
    Id_statustypes=widget.categoriesModel.Id_stateType;
    print("aa=${Id_statustypes}");
    if(Id_statustypes == "2"){
      dropdownValue="DisActive";
    }else{
      dropdownValue="Active";
    }

  }

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
              height: 10,
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
                              Provider.of<CategoryProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<CategoryProv>(context, listen: false).
                              getImage(ImageSource.gallery);
                            },
                            icon: const Icon(Icons.browse_gallery),
                          ),
                        ],
                      );
                    });
              },
              child:Container(
                padding: const EdgeInsets.all(8),
                width: width,
                height: height * .4,
                child: Consumer<CategoryProv>(
                  builder: (context, value, child) {
                    return value.image != null
                        ? Image.file(
                      value.  image!,
                      width: width,
                      height: height * 0.2,
                      fit: BoxFit.fill,
                    )
                        : Image.network(
                      ConsValues.BASEURL + widget.categoriesModel.imageURL,
                      width: 350,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(
                label: const Text("Categories Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Row(
              children: [
                SizedBox(
                  width: 40,
                ),
                Text(
                  'Status: $dropdownValue',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                DropdownButton<String>(
                  value: dropdownValue,
                  items: <String>['Active', 'DisActive']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 20),
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      print("jsonBody = $newValue");
                      dropdownValue = newValue!;
                    });
                    if (dropdownValue == "DisActive") {
                      Id_statustypes = "2";
                    } else {
                      Id_statustypes = "1";
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustButton(
          buttonText: "Save",
          onTap: () async {
            await Provider.of<CategoryProv>(context, listen: false)
                .UpdateCategory(
                    index: widget.index,
                    Id: widget.categoriesModel.id,
                    name: _name.text,
                    Id_statustypes: Id_statustypes);
            Navigator.pop(context);
          },
      ),
    );
  }
}
