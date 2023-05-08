import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/const_values.dart';
import 'package:provider/provider.dart';
import '../providers/orderHesDet_Pro.dart';

class OrderHesDetScreen extends StatefulWidget {
  var idOrders;


  @override
  OrderHesDetScreen({ required this.idOrders});
  State<OrderHesDetScreen> createState() => _OrderHesDetScreenState();
}

class _OrderHesDetScreenState extends State<OrderHesDetScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<OrderDetProv>(context, listen: false).
    getOrderHesDet(idOrders: widget.idOrders);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<OrderDetProv>(
        builder: (context, value, child) {
          return ListView.builder(
              itemCount: value.listOrderHesDet.length,
              itemBuilder: (context, index){
                return Column(
                  children: [
                    Image.network(
                        ConsValues.BASEURL+
                        value.listOrderHesDet[index].ImageURL),
                    SizedBox(height: 10,),
                    Text(value.listOrderHesDet[index].Name,
                style: TextStyle(fontSize: 20,
                color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text(value.listOrderHesDet[index].Price.toString(),
                      style: TextStyle(fontSize: 20,
                      color: Colors.black,),),
                    SizedBox(height: 10,),
                    Text(value.listOrderHesDet[index].Count,
                style: TextStyle(fontSize: 20,
                color: Colors.black,),
                    ),
                  ],
                );
              }
          );
        }),
    );
  }
}
