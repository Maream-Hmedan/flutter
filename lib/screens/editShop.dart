import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/categoriesAdmin.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/catigores_image.dart';
import '../moudels/shop.dart';
import '../providers/categories_prov.dart';
import '../providers/shop_prov.dart';
import 'addImage_screen.dart';

class EditShopScreen extends StatefulWidget {
  Shop  shop ;
  int index;

  EditShopScreen({required this.shop, required this.index});

  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  var width;
  var height;
  String dropdownValue = '';
  var Id_statustypes;
  var Id_category;
  var name;
  var NAME;
  var Id_categories;


  CategoriesModel?  selectedCategoriesValue;


  TextEditingController _name = TextEditingController();
  @override
  void initState(){
    super.initState();
    _name.text=widget.shop.name;
    Id_statustypes=widget.shop.Id_stateType;
    Id_categories=widget.shop.Id_categories;
    if(Id_statustypes == "2"){
      dropdownValue="DisActive";
    }else{
      dropdownValue="Active";
    }
    Provider.of<CategoryProv>(context, listen: false).
    getCategoriesAdmin().then((value) {
      selectedCategoriesValue = value.firstWhere(
          (category) =>  category.id == Id_categories,
      );
      setState(() {

      });
      name=selectedCategoriesValue!.name;
      Id_category=selectedCategoriesValue!.id;
    },

    );


  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body:SingleChildScrollView(
        child: Column(
          children:  [
            const SizedBox(height: 50,),
            InkWell(
              onTap: (){
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Select Image"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<ShopProv>(context, listen: false).
                              getImage(ImageSource.camera);
                            },
                            icon: const Icon(Icons.camera_alt_outlined),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Provider.of<ShopProv>(context, listen: false).
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
                child: Consumer<ShopProv>(
                  builder: (context, value, child) {
                    return value.image != null
                        ? Image.file(
                      value.  image!,
                      width: width,
                      height: height * 0.2,
                      fit: BoxFit.fill,
                    )
                        :  Image.network(
                      ConsValues.BASEURL + widget.shop.imageURL,
                      width: 350,
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 60,),
            TextField(controller: _name,

              decoration: InputDecoration(
                label: const Text("Shop Name"),
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
                    value.listCategoriesModelAdmin.length;
                    return DropdownButton<CategoriesModel>(
                      value: selectedCategoriesValue,
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
                          selectedCategoriesValue = Value;
                          Id_category=selectedCategoriesValue!.id;
                          name=selectedCategoriesValue!.name;
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
      bottomNavigationBar: CustButton(
        buttonText: "Save",
        onTap: () async {
          await Provider.of<ShopProv>(context, listen: false)
              .UpdateShop(
            Id_categories:Id_category,
              index: widget.index,
              Id: widget.shop.id,
              name: _name.text,
              Id_statustypes: Id_statustypes);
          Navigator.pop(context);
        },
      ),
    );
  }

}
