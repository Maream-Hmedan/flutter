import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../custButton.dart';
import '../general.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _Password = TextEditingController();
  final TextEditingController _PasswordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _Password,
            obscureText:true,
            decoration: InputDecoration(
              icon: const Icon(Icons.password),
              label: const Text("New Password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _PasswordCon,
            obscureText:true,
            decoration: InputDecoration(
              icon: const Icon(Icons.password_rounded),
              label: const Text("Config New Password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),

            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustButton(
              buttonText: "Save",
              onTap: () {
                if (_Password.text == _PasswordCon.text) {
                  updatePassword();
                }else{
                  showDialog(
                    context:context,
                    builder: (context){
                      return AlertDialog(
                        icon: Icon(Icons.error),
                        content: const Text("password does not match"),
                        actions: [
                          TextButton(onPressed:(){
                            Navigator.pop(context);
                          } , child: const Text("ok"),),
                        ],
                      );
                    },);
                }
              }
          ),
        ],
      ),
    );
  }
  updatePassword(){
    General.getPrefString(ConsValues.ID, "").then(
        (idUser) async {
          final response = await http.post(
            Uri.parse(
              "${ConsValues.BASEURL}updatePassword.php",
            ),
            body: {
              "Id": idUser,
              "Password":_Password.text,
            },
          );
          if (response.statusCode == 200) {
              General.savePrefString(ConsValues.PASSWORD, _Password.text);
              showDialog(
                context:context,
                builder: (context){
                  return AlertDialog(
                    icon: Icon(Icons.update),
                    content: const Text("Your Password Update"),
                    actions: [
                      TextButton(onPressed:(){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      } , child: const Text("ok"),),
                    ],
                  );
                },);
            }
          }
    );
  }


}
