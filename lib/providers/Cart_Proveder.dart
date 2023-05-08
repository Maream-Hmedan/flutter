import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../general.dart';
import '../moudels/cart_model.dart';

class CartProv extends ChangeNotifier {
  List<CartModel> listCartModel = [];
  double totalPrice = 0;

  addToCart({required var idItem}) async {
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
            print("uu=${idUser}");
            print("ii=${idItem}");
        await http.post(Uri.parse("${ConsValues.BASEURL}addToCart.php"), body: {
          "Id_users": idUser,
          "Id_items": idItem,
        });
      },
    );
  }

  getCart() async {
    listCartModel = [];
    General.getPrefString(ConsValues.ID, "").then(
          (idUser) async {
        final response = await http.post(
          Uri.parse(
            "${ConsValues.BASEURL}getCart.php",
          ),
          body: {
            "Id_users": idUser,
          },
        );
        if (response.statusCode == 200) {
          var jsonBody = jsonDecode(response.body);
          var cart = jsonBody["cart"];
          for (Map i in cart) {
            listCartModel.add(
              CartModel(
                Id_items: i['Id_items'],
                Id: i['Id'],
                Count: i['Count'],
                ImageURL: i['ImageURL'],
                Price: i['Price'],
                Name: i['Name'],
              ),
            );
            getTotalPrice();
          }
        }
      },
    );
  }
updateCart({required var index,required var count}) async {
    await http.post(
      Uri.parse("${ConsValues.BASEURL}updateCart.php"),
      body: {"Id":listCartModel[index].Id,"Count":count.toString(),}
    );
    listCartModel[index].Count=count;
    getTotalPrice();
}
deleteFromCart({required var index}) async {
    await http.post(
        Uri.parse("${ConsValues.BASEURL}deleteFromCart"),
      body: {"Id":listCartModel[index].Id}

    );
    listCartModel.removeAt(index);
    getTotalPrice();
 }
getTotalPrice(){
    totalPrice=0;
    for(CartModel cartModal in listCartModel){
      totalPrice=totalPrice+(cartModal.Price*cartModal.Count);
    }
    notifyListeners();
}
}

