import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const_values.dart';
import 'package:flutter_project/general.dart';
import 'package:flutter_project/screens/password_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../custButton.dart';
import 'login_screen.dart';
import 'main_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
   TextEditingController _email = TextEditingController();

   TextEditingController _phone = TextEditingController();
   TextEditingController _name = TextEditingController();

   @override
   void initState(){
     super.initState();
     get();

   }
   get() async {
      General.getPrefString(ConsValues.EMAIL, "").then(
         (value){
           _email.text=value;
         }
     );

      General.getPrefString(ConsValues.PHONE, "").then(
             (value){
           _phone.text=value;
         }
     );
      General.getPrefString(ConsValues.NAME, "").then(
             (value){
           _name.text=value;
         }
     );
   }


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
            controller:_email,
            decoration: InputDecoration(
              icon: const Icon(Icons.email),
              label: const Text("Email"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _phone,

            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              icon: const Icon(Icons.phone),
              label: const Text("phone"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),

            ),
          ),

          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: _name,

            decoration: InputDecoration(
              icon: const Icon(Icons.person),
              label: const Text("Name"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustButton(
              buttonText: "Save",
              onTap: () {
                updateProfile();
              }
                ),
        ],
      ),

    );
  }
   updateProfile() async {General.getPrefString(ConsValues.ID, "").then(
       (idUser) async{
     final response = await http.post(
       Uri.parse("${ConsValues.BASEURL}updateProfile.php"),
       body: {
         "Id":idUser,
         "Email": _email.text,
         "Name": _name.text,
         "Phone": _phone.text,
       },
     );

     if(response.statusCode==200){
       General.savePrefString(ConsValues.NAME, _name.text);
       General.savePrefString(ConsValues.EMAIL, _email.text);
       General.savePrefString(ConsValues.PHONE, _phone.text);
       get();

     }
   }
   );
   }

}
