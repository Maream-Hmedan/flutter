import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/screens/orders_admin.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../const_values.dart';
import '../custButton.dart';
import 'adminBanner_Screen.dart';
import 'adminShop.dart';
import 'categoriesAdmin.dart';
import 'itemAdmin.dart';

class MainAdminScreen extends StatefulWidget {
  const MainAdminScreen({Key? key}) : super(key: key);

  @override
  State<MainAdminScreen> createState() => _MainAdminScreenState();
}

class _MainAdminScreenState extends State<MainAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CustButton(
            buttonText: "Banner",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AdminBannerScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustButton(
            buttonText: "Item",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ItemAdminScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustButton(
            buttonText: "Shop",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AdminShopScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustButton(
            buttonText: "Categories",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CategoriesAdminScreen();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustButton(
            buttonText: "Orders",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return OrdersAdmin();
                  },
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          CustButton(
            buttonText: "LogOut",
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    icon: Icon(Icons.logout_sharp),
                    content: Text("Are You Sure You Want To LogOut"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () async {
                          SharedPreferences pref =
                          await SharedPreferences.getInstance();
                          await pref.remove(ConsValues.ID);
                          Navigator.pop(context);

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const SplashScreen(),
                            ),
                          );
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
