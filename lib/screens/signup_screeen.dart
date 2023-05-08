import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project/general.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../const_values.dart';
import '../custButton.dart';
import 'login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SignUP"),),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _email,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              label: Text("Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _password,
            obscureText:true,
            decoration: InputDecoration(
              icon: Icon(Icons.password),
              label: Text("Password"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _phone,

            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: Icon(Icons.phone),
              label: Text("phone"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),

            ),
          ),

          SizedBox(
            height: 20,
          ),
          TextField(
            controller: _name,

            decoration: InputDecoration(
              icon: Icon(Icons.person),
              label: Text("Name"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
          SizedBox(
            height: 60,
          ),
          CustButton(buttonText: "SignUp",
              onTap: () {

             signup();
              }

              )
        ],
      ),

    );


  }
  signup() async {
    EasyLoading.show(status: 'loading...');
    final response = await http.post(
        Uri.parse("${ConsValues.BASEURL}SignUp.php"),
        body: {
          "Email": _email.text,
          "Password": _password.text,
          "Name": _name.text,
          "Phone": _phone.text,
        },

    );

    EasyLoading.dismiss();
    if(response.statusCode==200){
      Navigator.pop(context);
    }else{
      showDialog(
        context:context,
        builder: (context){
          return AlertDialog(
            icon: Icon(Icons.error),
            content: const Text("signUp failed email exsist"),
            actions: [
              TextButton(onPressed:(){
                Navigator.pop(context);
              } , child: const Text("ok"),),
            ],
          );
        },);
    }


  }

}
