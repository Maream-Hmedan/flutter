import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../const_values.dart';
import '../custButton.dart';
import '../providers/Cart_Proveder.dart';
import 'map_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProv>(context, listen: false).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Consumer<CartProv>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listCartModel.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.all(8),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * .2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            ConsValues.BASEURL +
                            value.listCartModel[index].ImageURL,
                            width: 150,
                            height:
                            (MediaQuery
                                .of(context)
                                .size
                                .height * .2) - 16,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Text(
                                value.listCartModel[index].Name,
                                style: TextStyle(
                                  fontSize: 25,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Provider.of<CartProv>(
                                          context, listen: false).updateCart(
                                          index: index,
                                          count: value.listCartModel[index]
                                              .Count + 1);
                                    },
                                    icon: Icon(
                                      Icons.add,
                                    ),
                                  ),
                                  Text(
                                    value.listCartModel[index].Count.toString(),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (value.listCartModel[index].Count !=
                                          1) {
                                        Provider.of<CartProv>(
                                            context, listen: false).updateCart(
                                            index: index,
                                            count: value.listCartModel[index]
                                                .Count - 1);
                                      } else {
                                        Provider.of<CartProv>(
                                            context, listen: false)
                                            .deleteFromCart(
                                            index: index);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.remove,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Total Price = "),
                Consumer<CartProv>(
                  builder: (context, value, child) {
                    return Text(
                      value.totalPrice.toString(),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: CustButton(buttonText: "Next", onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MapScreen();
            },
          ),
        );
      }
      ),
    );
  }
}
