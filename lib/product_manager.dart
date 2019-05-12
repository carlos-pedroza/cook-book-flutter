import "package:flutter/material.dart";
import './product_card.dart';

class ProductManager extends StatefulWidget {
  final List<String> products;
  ProductManager(this.products);

  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.1),
          child: ProductCard(widget.products), //must sustitud by producs cards
        ),
      ],
    );
  }
}
