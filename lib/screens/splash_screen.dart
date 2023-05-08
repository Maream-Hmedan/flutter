import 'dart:async';
import 'package:flutter/material.dart';
import '../const_values.dart';
import '../general.dart';
import 'adminMain_screen.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //checkUserLogin()
  // {
  //     General.getPrefString(ConsValues.ID, "").then(
  //           (value) {
  //         if (value == "") {
  //           Timer(
  //             const Duration(seconds: 3),
  //                 () => Navigator.of(context).pushReplacement(
  //               MaterialPageRoute(
  //                 builder: (BuildContext context) => const loginScreen(),
  //               ),
  //             ),
  //           );
  //         } else{
  //           General.getPrefString(ConsValues.USERTYPE,"").then((value) {
  //             if(value == "2"){
  //               Timer(
  //                 const Duration(seconds: 3),
  //                     () => Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(
  //                     builder: (BuildContext context) => const mainAdminScreen(),
  //                   ),
  //                 ),
  //               );
  //             } else{
  //               Timer(
  //                 const Duration(seconds: 3),
  //                     () => Navigator.of(context).pushReplacement(
  //                   MaterialPageRoute(
  //                     builder: (BuildContext context) => const MainScreen(),
  //                   ),
  //                 ),
  //               );
  //             }
  //           });
  //
  //         }
  //       },
  //     );
  //   }


  @override
    void initState(){
      super.initState();
      //checkUserLogin();
      Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const LoginScreen(),
            ),
            ),
      );

    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Image.asset('assets/images/logo.png'),
        ),
      );
    }

}
