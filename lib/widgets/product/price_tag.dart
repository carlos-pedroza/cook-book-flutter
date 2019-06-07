import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  double _price;

  PriceTag(this._price);

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade800,
        child: Text('\$'),
      ),
      label: Container(
        child: Text(
          _price.toString(),
          textAlign: TextAlign.right,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
