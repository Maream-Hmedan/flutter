import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../const_values.dart';
import '../moudels/item_model.dart';

class ItemProv extends ChangeNotifier {
  List<ItemModel> listItemModel = [];
  List<ItemModel> listItemAdmin = [];
  File? image ;

  getItems({required var Id_shops}) async {
    listItemModel = [];
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}getItems.php"),
      body: {
        "Id_shops": Id_shops,
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];
      for (Map i in items) {
        listItemModel.add(ItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  getItemsAdmin() async {
    listItemAdmin = [];
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}getItemsAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody['items'];
      for (Map i in items) {
        listItemAdmin.add(ItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future addNewItems({
    required String name,
    required String description,
    required String price,
    required String Id_shop,
    required String Id_statustypes,
    required List<XFile> listImages,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewItem.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image!.path);
    request.fields['Name'] = name;
    request.fields['Description'] = description;
    request.fields['Price'] = price;
    request.fields['Id_shops'] = Id_shop;
    request.fields['Id_statustypes'] = Id_statustypes;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listItemAdmin.add(ItemModel.fromJson(data));
    var ID = data['Id'];

    for (XFile x in listImages) {
      await addNewItemImages(image: File(x.path), Id_items: ID.toString());
    }

    notifyListeners();
  }

  Future addNewItemImages({
    required File image,
    required String Id_items,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewItemImage.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image.path);
    request.fields['Id_items'] = Id_items;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
  }

  Future UpdateItem({
    required int index,
    required String name,
    required String description,
    required String price,
    required String Id_shop,
    required String Id_statustype,
    required Id,

  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}UpdateItem.php"));
    request.fields['Name'] = name;
    request.fields['Description'] = description;
    request.fields['Price'] = price;
    request.fields['Id_shops'] = Id_shop;
    request.fields['Id_statetype'] = Id_statustype;
    request.fields['Id'] = Id;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listItemAdmin[index]=ItemModel.fromJson(data);
    notifyListeners();
  }

  getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    final XFile? xImage = await picker.pickImage(source: imageSource);
    if (xImage != null) {
      image = File(xImage.path);
      notifyListeners();
    }
  }
}
