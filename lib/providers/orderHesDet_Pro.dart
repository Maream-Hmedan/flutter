import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../general.dart';
import '../moudels/OrderHesDetalies.dart';


class OrderDetProv extends ChangeNotifier {
  List<OrderHesDet> listOrderHesDet = [];

  getOrderHesDet({required var idOrders}) async {
    listOrderHesDet = [];
        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getOrderHesDet.php",
          ),
          body: {
            "Id_orders": idOrders,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);

          var ordersDet = jsonBody['OrdersDet'];
          for (Map i in ordersDet) {
            listOrderHesDet.add(
              OrderHesDet(
                Count: i['Count'],
                Name: i['Name'],
                Price: i['Price'],
                ImageURL: i['ImageURL'],
              ),
            );
            notifyListeners();
          }
        }
  }
}
