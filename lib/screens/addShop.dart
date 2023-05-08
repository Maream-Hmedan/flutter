import 'dart:io';
import '../providers/categories_prov.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/moudels/catigores_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../custButton.dart';
import '../providers/shop_prov.dart';

class addShop extends StatefulWidget {
  const addShop({Key? key}) : super(key: key);

  @override
  State<addShop> createState() => _addShopState();
}

class _addShopState extends State<addShop> {
  File ? image =null;
  var width;
  var height;

  TextEditingController _name = TextEditingController();
  String dropdownValue = 'DisActive';
  var Id_statustypes;
  var Id_category;
     var name;

  CategoriesModel?  selectedValue;
  void initState() {
    super.initState();
    Provider.of<CategoryProv>(context, listen: false).getCategoriesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Select Image"),
                              actions: [
                                IconButton(onPressed: () {
                                  Navigator.pop(context);
                                  getImage(ImageSource.camera);
                                },
                                  icon: const Icon(Icons.camera_alt_outlined),
                                ),
                                IconButton(onPressed: () {
                                  Navigator.pop(context);
                                  getImage(ImageSource.gallery);
                                },
                                  icon: const Icon(Icons.browse_gallery),
                                ),
                              ],
                            );
                          }
                      );
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
                          : const Icon((Icons.image),),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(controller: _name,
                    decoration: InputDecoration(
                      label: const Text(" Shop Name"),
                      hintText: "ADD Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      const SizedBox(width: 40,),
                      Text(
                        'Status: $dropdownValue',
                        style: const TextStyle(fontSize: 20,),
                      ),
                      const SizedBox(width: 40,),
                      DropdownButton<String>(

                        value: dropdownValue,
                        items: <String>[ 'Active', 'DisActive']
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
                            Id_statustypes ="1";

                          }
                        },

                      ),

                    ],
                  ),
                  const SizedBox(height: 40,),
                  Row(
                    children: [
                      const SizedBox(width: 20,),
                      Text(
                        'Category Name:$name',
                        style: const TextStyle(fontSize: 20,),
                      ),
                      const SizedBox(width: 40,),
                      Consumer<CategoryProv>(
                      builder: (context, value, child) {
                        return DropdownButton<CategoriesModel>(
                          value: selectedValue,
                          items: value.listCategoriesModelAdmin
                              .map<DropdownMenuItem<CategoriesModel>>((
                              CategoriesModel value) {
                            return DropdownMenuItem <CategoriesModel>(
                              value: value,
                              child: Text(value.name),
                            );
                          }).toList(),
                          style: const TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (CategoriesModel? Value) {
                            setState(() {
                              selectedValue = Value;
                              Id_category=selectedValue!.id;
                              name=selectedValue!.name;
                              print("selectedValue = $name");
                              print("Value = $Id_category");
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

      bottomNavigationBar: CustButton(buttonText: "Save", onTap: () async {
        await Provider.of<ShopProv>(context, listen: false)
            .addNewShops(
            image: image!,
            name: _name.text,
            Id_statustypes: Id_statustypes,
            Id_categories: Id_category);
        Navigator.pop(context);
      },
      ),
    );
  }
  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source:imageSource);
    if(xImage != null){
      image=File(xImage.path);
      setState(() {

      });
    }
  }

  }

