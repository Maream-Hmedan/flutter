import 'package:flutter/material.dart';
import 'package:flutter_project/providers/orderHes_Pro.dart';
import 'package:provider/provider.dart';

import 'orderHesDet_Screen.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({Key? key}) : super(key: key);

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderProv>(context, listen: false).getOrderHesAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<OrderProv>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.listOrderHes.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return OrderHesDetScreen(
                            idOrders: value.listOrderHes[index].Id);
                      },
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.34,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      20,
                    ),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        value.listOrderHes[index].Note,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].TotalPrice.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].Latitude,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].Longitude,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        value.listOrderHes[index].orderstate,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              value.updateOrderState(
                                  index: index, Id_orderstate: "1");

                            },
                            child: Text("wating"),
                          ),
                          TextButton(
                            onPressed: () {
                              value.updateOrderState(
                                  index: index, Id_orderstate: "2");
                            },
                            child: Text("approve"),
                          ),
                          TextButton(
                            onPressed: () {
                              value.updateOrderState(
                                  index: index, Id_orderstate: "3");

                            },
                            child: Text("cancel"),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
