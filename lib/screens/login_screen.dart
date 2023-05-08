import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project/const_values.dart';
import 'package:flutter_project/custButton.dart';
import 'package:flutter_project/screens/signup_screeen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

import '../general.dart';
import 'adminMain_screen.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool showErrorEmail= false;
  bool showErrorPassword= false;
  final LocalAuthentication auth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
    checkUserIsLoginBefore();
  }

  checkUserIsLoginBefore() async {
    String email=await General.getPrefString((ConsValues.EMAIL), "");
    String password=await General.getPrefString((ConsValues.PASSWORD), "");

    if(email != "" && password != "" ){
      try {
        final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Please authenticate to show account balance',
            options: const AuthenticationOptions(useErrorDialogs: false,
            biometricOnly: true,),
        );

        login(email: email, password: password);
        // ···
      } on PlatformException catch (e) {
        if (e.code == auth_error.notEnrolled) {
          // Add handling of no hardware here.
        } else if (e.code == auth_error.lockedOut ||
            e.code == auth_error.permanentlyLockedOut) {
          // ...
        } else {
          // ...
        }
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOGIN"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/logo.png"),
            TextField(
              controller: _email,
              keyboardType:TextInputType.emailAddress,
              decoration: InputDecoration(
                icon: const Icon(Icons.email),
                label: const Text("Email"),
                helperText: "demo@demo.com",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(
                icon: const Icon(Icons.password),
                label: const Text("Password"),
                helperText: "******",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

            ),
            CustButton(
                buttonText: "Login",
                onTap: (){
                   login(email: _email.text,password: _password.text);
                }
            ),
            CustButton(
                buttonText: "SignUp",
                onTap: () {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) {
                    return const SignupScreen();
                  }
                  ),
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
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
  }
}

