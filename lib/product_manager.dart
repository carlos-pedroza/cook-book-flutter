import "package:flutter/material.dart";
import './product_card.dart';

class ProductManager extends StatefulWidget {
  final List<Map<String,String>> products;
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
    try {

      Widget _productCard = Center(
        child: Text('No products found!'),
      );
      if (widget.products.length > 0) {
        _productCard = ProductCard(widget.products);
      }

      return Expanded(
        child: _productCard,
      );

    } catch (e) {
      return Container();
    }
  }
}
