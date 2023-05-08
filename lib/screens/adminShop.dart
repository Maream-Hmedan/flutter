import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/shop_prov.dart';
import 'addShop.dart';
import 'editShop.dart';



class AdminShopScreen extends StatefulWidget {
  const AdminShopScreen({Key? key}) : super(key: key);

  @override
  State<AdminShopScreen> createState() => _AdminShopScreenState();
}

class _AdminShopScreenState extends State<AdminShopScreen>{
@override
void initState() {
  super.initState();
  Provider.of<ShopProv>(context, listen: false).getShopAdmin();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Consumer<ShopProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemBuilder: (context, index) {
                return Container(
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
                      SizedBox(width: 20,),
                      Image.network(
                        ConsValues.BASEURL +
                        value.listShopAdmin[index].imageURL,
                        width: 150,
                        height: 150,
                      ),
                      SizedBox(width: 20,),
                      Text(
                        value.listShopAdmin[index].name,
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(width: 40,),
                      IconButton(onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return  EditShopScreen(
                                index: index,
                                shop:value.listShopAdmin[index],
                              );
                            },
                          ),
                        );
                      }
                        , icon: Icon(Icons.edit),),
                    ],
                  ),
                );
            },
            itemCount: value.listShopAdmin.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const addShop();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
