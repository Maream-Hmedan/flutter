import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../general.dart';
import '../screens/adminMain_screen.dart';
import '../screens/main_screen.dart';

class UserProv extends ChangeNotifier{
  var context;

  login({required String email,required String password}) async {
    EasyLoading.show(status: 'loading...');

    final response = await http.post(
      Uri.parse("${ConsValues.BASEURL}login.php"),
      body: {"Email": email, "Password": password},

    );
    EasyLoading.dismiss();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      if (jsonBody['result']) {
        General.savePrefString(ConsValues.ID, jsonBody['Id']);
        General.savePrefString(ConsValues.NAME, jsonBody['Name']);
        General.savePrefString(ConsValues.EMAIL, jsonBody['Email']);
        General.savePrefString(ConsValues.PHONE, jsonBody['Phone']);
        General.savePrefString(ConsValues.USERTYPE, jsonBody['UserType']);
        if(jsonBody['UserType']=="2"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainAdminScreen();
              },
            ),
          );
        }else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const MainScreen();
              },
            ),
          );
        }

      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              icon: const Icon(Icons.error),
              content: Text(jsonBody['msg']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      }
    }
    notifyListeners();
  }

}