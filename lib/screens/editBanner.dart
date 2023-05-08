import 'package:flutter/material.dart';
import 'package:flutter_project/custButton.dart';
import 'package:flutter_project/moudels/banner_images.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/banner_prov.dart';
import 'addImage_screen.dart';


class EditBannerScreen extends StatefulWidget {
  BannerImages bannerImages;
  EditBannerScreen({required this.bannerImages});

  @override
  State<EditBannerScreen> createState() => _EditBannerScreenState();
}


class _EditBannerScreenState extends State<EditBannerScreen> {
  TextEditingController _url = TextEditingController();
  void initState(){
    super.initState();
    _url.text=widget.bannerImages.url;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
          child: Column(
            children:  [
              const SizedBox(height: 50,),
             InkWell(
               onTap: (){
                 showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                         title: const Text("Select Image"),
                         actions: [
                           IconButton(
                             onPressed: () {
                               Navigator.pop(context);
                               Provider.of<BannerProv>(context, listen: false).
                               getImage(ImageSource.camera);
                             },
                             icon: const Icon(Icons.camera_alt_outlined),
                           ),
                           IconButton(
                             onPressed: () {
                               Navigator.pop(context);
                               Provider.of<BannerProv>(context, listen: false).
                               getImage(ImageSource.gallery);
                             },
                             icon: const Icon(Icons.browse_gallery),
                           ),
                         ],
                       );
                     });
               },
               child: Image.network(
                 ConsValues.BASEURL +
                 widget.bannerImages.imageURL,
               width: 350,
               ),
             ),
              const SizedBox(height: 60,),
               TextField(controller: _url,

                 decoration: InputDecoration(
                   label: const Text("URL"),
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),

                 ),
               ),


            ],
          ),
        ),
      bottomNavigationBar:  CustButton(buttonText: "Save", onTap: (){

      }),


    );
  }
}
