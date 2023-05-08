import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_project/providers/Cart_Proveder.dart';
import 'package:flutter_project/providers/Images_Prov.dart';
import 'package:flutter_project/providers/banner_prov.dart';
import 'package:flutter_project/providers/categories_prov.dart';
import 'package:flutter_project/providers/items_prov.dart';
import 'package:flutter_project/providers/orderHesDet_Pro.dart';
import 'package:flutter_project/providers/orderHes_Pro.dart';
import 'package:flutter_project/providers/shop_prov.dart';
import 'package:flutter_project/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider<BannerProv>(
        create: (_) => BannerProv(),),
        ChangeNotifierProvider<CategoryProv>(
         create: (_) => CategoryProv(),
           ),
          ChangeNotifierProvider<ShopProv>(
            create: (_) => ShopProv(),
          ),
          ChangeNotifierProvider<ItemProv>(
            create: (_) => ItemProv(),
          ),
          ChangeNotifierProvider<IteamImagesProv>(
            create: (_) => IteamImagesProv(),
          ),
          ChangeNotifierProvider<CartProv>(
            create: (_) => CartProv(),
          ),
          ChangeNotifierProvider<OrderProv>(
            create: (_) => OrderProv(),
          ),
          ChangeNotifierProvider<OrderDetProv>(
            create: (_) => OrderDetProv(),
          ),

         ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
          primarySwatch: Colors.blue,
              ),
               home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
            builder: EasyLoading.init(),
             ),
       );
  }
}
