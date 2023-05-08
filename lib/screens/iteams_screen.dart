import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../providers/Images_Prov.dart';
import '../providers/items_prov.dart';
import 'ItemDetScreen.dart';

class ItemsScreen extends StatefulWidget {
  var IdShop;

  ItemsScreen({required this.IdShop});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProv>(context, listen: false).getItems(
      Id_shops: widget.IdShop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ItemProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.listItemModel.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ItemDetScreen(
                          itemModel: value.listItemModel[index],
                        );
                      },
                    ),
                  );
                },
                child: Column(
                  children: [
                    Image.network(
                      ConsValues.BASEURL +
                      value.listItemModel[index].ImageURL,
                    ),
                    Text(
                      value.listItemModel[index].Name,
                    ),
                    Text(
                      value.listItemModel[index].Price.toString(),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
