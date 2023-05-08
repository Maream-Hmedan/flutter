import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project/moudels/shop.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../const_values.dart';

class ShopProv extends ChangeNotifier {
  List<Shop> listShop = [];
  List<Shop> listShopAdmin = [];
  File? image ;

  getShops({required var Id_categories}) async {
    listShop = [];
    final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}getShops.php"),
        body: {"Id_categories": Id_categories});
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody['shops'];

      for (Map i in shops) {
        listShop.add(Shop.fromJson(i));
      }
      notifyListeners();
    }
  }

  Future<List<Shop>> getShopAdmin() async {
    listShopAdmin = [];
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}getShopsAdmin.php"),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody['shops'];
      for (Map i in shops) {
        listShopAdmin.add(Shop.fromJson(i));
      }
      notifyListeners();
    }
    return listShopAdmin;
  }

  Future addNewShops({
    required File image,
    required String name,
    required String Id_statustypes,
    required String Id_categories,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}addNewShop.php"));
    var pic = await http.MultipartFile.fromPath("fileToUpload", image.path);
    request.fields['Name'] = name;
    request.fields['Id_statustypes'] = Id_statustypes;
    request.fields['Id_categories'] = Id_categories;
    request.files.add(pic);
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listShopAdmin.add(Shop.fromJson(data));
    notifyListeners();
  }

  Future UpdateShop({
    required String Id,
    File? image,
    required String name,
    required String Id_statustypes,
    required String Id_categories,
    required int index,
  }) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("${ConsValues.BASEURL}UpdateShop.php"));
    if (image != null) {
      var pic = await http.MultipartFile.fromPath("fileToUpload", image!.path);
      request.files.add(pic);
    }
    request.fields['Name'] = name;
    request.fields['Id_statetype'] = Id_statustypes;
    request.fields['Id_categories'] = Id_categories;
    request.fields['Id'] = Id;
    var response = await request.send();
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    var jsonBody = jsonDecode(responseString);
    var data = jsonBody['data'];
    listShopAdmin[index] = Shop.fromJson(data);
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
