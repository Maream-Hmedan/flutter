import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_project/providers/categories_prov.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../const_values.dart';
import '../custButton.dart';
import 'categoriesAdmin.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  @override
  var width;
  var height;
  TextEditingController _ID = TextEditingController();
  TextEditingController _name = TextEditingController();
  String dropdownValue = 'DisActive';
  var Id_statustypes;

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
                height: height * .2,
                child: Consumer<CategoryProv>(
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
              controller: _name,
              decoration: InputDecoration(
                label: const Text(" Categories Name"),
                hintText: "ADD Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
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
            const SizedBox(
              height: 270,
            ),
            CustButton(
              buttonText: "Save",
              onTap: () async {
                await Provider.of<CategoryProv>(context, listen: false)
                    .addNewCategories(
                    name: _name.text,
                    Id_statustypes: Id_statustypes);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
