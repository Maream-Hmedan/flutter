import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../moudels/item_model.dart';
import '../providers/Cart_Proveder.dart';
import '../providers/Images_Prov.dart';
import 'cart_screen.dart';

class ItemDetScreen extends StatefulWidget {
  ItemModel itemModel;

  ItemDetScreen({
    required this.itemModel,
  });

  @override
  State<ItemDetScreen> createState() => _ItemDetScreenState();
}

class _ItemDetScreenState extends State<ItemDetScreen> {
  var width;
  var height;

  @override
  void initState() {
    super.initState();
    Provider.of<IteamImagesProv>(context, listen: false).getItemImages(
      idItem: widget.itemModel.Id,
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width,
              height: height * .3,
              padding: EdgeInsets.all(8),
              child: Consumer<IteamImagesProv>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listImages.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Image.network(
                        ConsValues.BASEURL +
                        value.listImages[index].imageURL,
                        height: (height * .3) - 16,
                        width: width - 16,
                        fit: BoxFit.fill,
                      );
                    },
                  );
                },
              ),
            ),
            Text(widget.itemModel.Name),
            Text(widget.itemModel.Price.toString()),
            Text(widget.itemModel.Description),
          ],
        ),
      ),
      bottomNavigationBar: CustButton(
        buttonText: "Add To Cart",
        onTap: () async {

          await Provider.of<CartProv>(context, listen: false).addToCart(
           idItem: widget.itemModel.Id,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
      ),
    );
  }
}
