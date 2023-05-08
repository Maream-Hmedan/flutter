import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/items_prov.dart';
import 'addItem.dart';
import 'editItem.dart';

class ItemAdminScreen extends StatefulWidget {
  const ItemAdminScreen({Key? key}) : super(key: key);

  @override
  State<ItemAdminScreen> createState() => _ItemAdminScreenState();
}

class _ItemAdminScreenState extends State<ItemAdminScreen> {
  void initState() {
    super.initState();
    Provider.of<ItemProv>(context, listen: false).getItemsAdmin();
  }
  var width;
  var height;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
        body: Consumer<ItemProv>(
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
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Row(
                        children: [

                          Image.network(
                            ConsValues.BASEURL+
                                value.listItemAdmin[index].ImageURL,
                            height: 200,
                            width: 270,
                            fit: BoxFit.fitWidth,
                          ),
                          const SizedBox(width: 40,),

                          IconButton(onPressed: () { Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return EditItemAdminScreen(
                                  index: index,
                                  itemModel:value.listItemAdmin[index],
                                );
                              },
                            ),
                          );},
                            icon: const Icon(Icons.edit),)
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(value.listItemAdmin[index].Name),

                    ],

                  ),
                );
              },
                itemCount: value.listItemAdmin.length,
                scrollDirection:Axis.vertical
          );
        },
        ),
            floatingActionButton:FloatingActionButton(
                onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const AddItemScreen();
                  },
                ),
              );
            },
                child: const Icon(Icons.add),
      ),
    );
  }

}
