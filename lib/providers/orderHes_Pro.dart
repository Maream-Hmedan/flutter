import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../general.dart';
import '../moudels/Order_Hestory.dart';

class OrderProv extends ChangeNotifier {
  List<OrderHes> listOrderHes = [];

  getOrderHes() async {
    listOrderHes = [];
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {

        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getOrderHes.php",
          ),
          body: {
            "Id_users": idUser,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);

          var orders = jsonBody['orders'];
          for (Map i in orders) {
            listOrderHes.add(
              OrderHes(
                Id: i['Id'],
                Note: i['Note'],
                TotalPrice: i['TotalPrice'],
                Longitude: i['Longitude'],
                Latitude: i['Latitude'],
                orderstate: i['orderstate'],
              ),
            );
            notifyListeners();
          }
        }
      },
    );
  }

  getOrderHesAdmin() async {
    listOrderHes = [];

    final response = await http.post(
      Uri.parse(
        "${ConsValues.BASEURL}getOrderHesAdmin.php",
      ),
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);

      var orders = jsonBody['orders'];
      for (Map i in orders) {
        listOrderHes.add(
          OrderHes(
            Id: i['Id'],
            Note: i['Note'],
            TotalPrice: i['TotalPrice'],
            Longitude: i['Longitude'],
            Latitude: i['Latitude'],
            orderstate: i['orderstate'],
          ),
        );
        notifyListeners();
      }
    }
  }

  updateOrderState({required int index, required String Id_orderstate}) async {
    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}updateOrderState.php"),
      body: {
        "Id_orderstate": Id_orderstate,
        "Id": listOrderHes[index].Id,
      },
    );
    if (response.statusCode == 200) {
      Id_orderstate == "1"
          ? listOrderHes[index].orderstate = "wating"
          : Id_orderstate == "2"
          ? listOrderHes[index].orderstate = "approve"
          : listOrderHes[index].orderstate = "cancel";
      notifyListeners();
    }
  }
}
