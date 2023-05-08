import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/screens/setting_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

import '../const_values.dart';
import '../providers/banner_prov.dart';
import '../providers/categories_prov.dart';
import '../providers/shop_prov.dart';
import 'iteams_screen.dart';
import 'orderHes_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<BannerProv>(context, listen: false).getBannerImages();
    Provider.of<CategoryProv>(context, listen: false).getCategories();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const OrderHesScreen();
              },
            ),
          );
        }, icon: const Icon(Icons.list)),
          IconButton(onPressed: (){}, icon: const Icon(Icons.person)),
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const SettingScreen();
                },
              ),
            );
          }, icon: const Icon(Icons.settings)),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            width: width,
            height: height * .3,
            child: Consumer<BannerProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(value.listBannerImages[index].url));
                      },
                      child: Image.network(
                        ConsValues.BASEURL +
                        value.listBannerImages[index].imageURL,
                        height: (height * .3) - 16,
                        width: width - 16,
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: value.listBannerImages.length,
                  scrollDirection: Axis.horizontal,
                );
              },
            ),
          ),
          Container(
            width: width,
            height: height * .1,
            padding: const EdgeInsets.all(8),
            child: Consumer<CategoryProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Provider.of<ShopProv>(context, listen: false).getShops(
                          Id_categories: value.listCategoriesModel[index].id,
                        );
                      },
                      child: Container(
                        width: 80,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Text(
                          value.listCategoriesModel[index].name,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: value.listCategoriesModel.length,
                  scrollDirection: Axis.horizontal,
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Consumer<ShopProv>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ItemsScreen(
                                  IdShop: value.listShop[index].id,
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
                            children: [
                              Image.network(
                                ConsValues.BASEURL +
                                value.listShop[index].imageURL,
                                width: 150,
                                height: 150,
                              ),
                              Text(
                                value.listShop[index].name,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: value.listShop.length,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
