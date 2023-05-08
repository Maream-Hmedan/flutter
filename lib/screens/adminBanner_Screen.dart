import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../moudels/banner_images.dart';
import '../providers/banner_prov.dart';
import 'addBannere.dart';
import 'editBanner.dart';

class AdminBannerScreen extends StatefulWidget {
  const AdminBannerScreen({Key? key}) : super(key: key);

  @override
  State<AdminBannerScreen> createState() => _AdminBannerScreenState();
}

class _AdminBannerScreenState extends State<AdminBannerScreen> {
  var width;
  var height;


  void initState() {
    super.initState();
    Provider.of<BannerProv>(context, listen: false).getBannerImages();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body:Consumer<BannerProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditBannerScreen(
                            bannerImages:value.listBannerImages[index],
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                  child: Row(
                      children:[
                        const SizedBox(width: 10,),
                        Image.network(
                          ConsValues.BASEURL +
                          value.listBannerImages[index].imageURL,
                          height: 200,
                          width: 280,
                          fit: BoxFit.fitWidth,
                        ),
                        const SizedBox(width: 10,),
                        IconButton(onPressed: (){  Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditBannerScreen(
                                bannerImages:value.listBannerImages[index],
                              );
                            },
                          ),
                        );

                        }, icon:const Icon(Icons.edit),),
                      ] ,
                  ),
                ),
              );
            },
            itemCount: value.listBannerImages.length,
            scrollDirection: Axis.vertical,
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const AddBannerScreen();
                },
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
    );

  }
}
