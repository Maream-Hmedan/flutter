import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/item_model.dart';
import '../moudels/shop.dart';
import '../providers/items_prov.dart';
import '../providers/shop_prov.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
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

  File? image = null;
  var width;
  var height;

  TextEditingController _name = TextEditingController();
  TextEditingController _Des = TextEditingController();
  TextEditingController _Price = TextEditingController();
  String dropdownValue = 'DisActive';
  var Id_statustypes;
  Shop? selectedValue;
  var Id_shop;
  var Id_item;
  var name;

  void initState() {
    super.initState();
    Provider.of<ShopProv>(context, listen: false).getShopAdmin();
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
                              Provider.of<ItemProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<ItemProv>(context, listen: false).
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
                child: image != null
                    ? Image.file(
                  image!,
                  width: width,
                  height: height * 0.2,
                  fit: BoxFit.fill,
                )
                    : const Icon(
                  (Icons.image),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
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
            TextField(
              controller: _name,
              decoration: InputDecoration(
                label: const Text(" Item Name"),
                hintText: "ADD Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _Des,
              decoration: InputDecoration(
                label: const Text(" Description"),
                hintText: "ADD Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _Price,
              decoration: InputDecoration(
                label: const Text("Price"),
                hintText: "ADD Price",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
            const SizedBox(
              width: 40,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Shop Name:$name',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Consumer<ShopProv>(
                  builder: (context, value, child) {
                    return DropdownButton<Shop>(
                      value: selectedValue,
                      items: value.listShopAdmin
                          .map<DropdownMenuItem<Shop>>((Shop value) {
                        return DropdownMenuItem<Shop>(
                          value: value,
                          child: Text(value.name),
                        );
                      }).toList(),
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      onChanged: (Shop? Value) {
                        setState(() {
                          selectedValue = Value;
                          Id_shop = selectedValue!.id;
                          name = selectedValue!.name;
                          print("selectedValue = $name");
                          print("Value = $Id_shop");
                        });
                      },
                    );
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
          await Provider.of<ItemProv>(context, listen: false).addNewItems(
            name: _name.text,
            description: _Des.text,
            price: _Price.text,
            Id_statustypes: Id_statustypes,
            Id_shop: Id_shop,
            listImages: imagefiles,
          );
          Navigator.pop(context);
        },
      ),
    );
  }
}
