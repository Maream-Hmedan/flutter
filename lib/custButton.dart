import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustButton extends StatefulWidget {
  var buttonText;
  var onTap;

  CustButton({required this.buttonText,required this.onTap});

  @override
  State<CustButton> createState() => _CustButtonState();
}

class _CustButtonState extends State<CustButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          widget.buttonText,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),

    );
  }
}
