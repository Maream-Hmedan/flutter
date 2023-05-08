import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/item_model.dart';
import '../moudels/shop.dart';
import '../providers/Images_Prov.dart';
import '../providers/items_prov.dart';
import '../providers/shop_prov.dart';
import 'addImage_screen.dart';
import 'addImages.dart';

class EditItemAdminScreen extends StatefulWidget {
  ItemModel itemModel;
  int index;

  EditItemAdminScreen({required this.itemModel, required this.index});

  @override
  State<EditItemAdminScreen> createState() => _EditItemAdminScreenState();
}

class _EditItemAdminScreenState extends State<EditItemAdminScreen> {
  var width;
  var height;
  TextEditingController _name = TextEditingController();
  TextEditingController _desc = TextEditingController();
  TextEditingController _price = TextEditingController();
  String stateDropdownValue = " ";
  var Id_statustype;

  Shop? selectedShopValue;
  var Id_shop;
  var Id_item;
  var name;


  @override
  void initState() {
    super.initState();
    _name.text = widget.itemModel.Name;
    _desc.text = widget.itemModel.Description;
    _price.text = widget.itemModel.Price.toString();
    Id_statustype = widget.itemModel.Id_statetype;
    Id_shop = widget.itemModel.Id_shops;

    print("Id shop = ${Id_shop}");
    if (Id_statustype == "2") {
      stateDropdownValue = "DisActive";
    } else {
      stateDropdownValue = "Active";
    }

    Provider.of<IteamImagesProv>(context, listen: false).getItemImages(
      idItem: widget.itemModel.Id,
    );

    Provider.of<ShopProv>(context, listen: false).getShopAdmin().then(
      (value) {
        selectedShopValue = value.firstWhere(
          (shop) => shop.id == Id_shop,
        );
        setState(() {

        });
        name=selectedShopValue!.name;
      },
    );


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
                height: 50,
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
                child: Image.network(
                  ConsValues.BASEURL + widget.itemModel.ImageURL,
                  width: 350,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _name,
                decoration: InputDecoration(
                  label: const Text("Item Name"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _desc,
                decoration: InputDecoration(
                  label: const Text("Item Description"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextField(
                controller: _price,
                decoration: InputDecoration(
                  label: const Text("Item Price"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    'Status: $stateDropdownValue',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  DropdownButton<String>(
                    value: stateDropdownValue,
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
                        stateDropdownValue = newValue!;
                      });
                      if (stateDropdownValue == "DisActive") {
                        Id_statustype = "2";
                      } else {
                        Id_statustype = "1";
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
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
                        value: selectedShopValue,
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
                            selectedShopValue = Value;
                            Id_shop = selectedShopValue!.id;
                            name = selectedShopValue!.name;
                            print("selectedShopValue = $name");
                            print("Value = $Id_shop");
                          });
                        },
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Provider.of<IteamImagesProv>(context, listen: false)
                        .deleteItemImages(
                      index: widget.index,
                      idItem: widget.itemModel.Id,
                    );
                  },
                  child: Text("Delete Iteam Images")),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return addImages();
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Center(
                      child: Text("Add Iteam Images ",
                          style: TextStyle(
                            fontSize: 20,
                          )),
                    ),
                    Container(
                      width: width,
                      height: height * .3,
                      padding: EdgeInsets.all(8),
                      child: Consumer<IteamImagesProv>(
                        builder: (context, value, child) {
                          return ListView.builder(
                            itemCount: value.listImages.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return Image.network(
                                ConsValues.BASEURL +
                                    value.listImages[index].imageURL,
                                height: (height * .3) - 16,
                                width: width - 16,
                                fit: BoxFit.fill,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustButton(
          buttonText: "Save",
          onTap: () async {
            await Provider.of<ItemProv>(context, listen: false).UpdateItem(
                index: widget.index,
                Id: widget.itemModel.Id,
                description: _desc.text,
                Id_shop: Id_shop,
                price: _price.text,
                name: _name.text,
                Id_statustype: Id_statustype);

            Navigator.pop(context);
          },
        ));
  }
}
