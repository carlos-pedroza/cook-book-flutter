import "package:flutter/material.dart";
import './product_card.dart';
import './models/product.dart';

class ProductManager extends StatefulWidget {
  final List<Product> products;
  final Function _deleteProduct;

  ProductManager(this.products, this._deleteProduct);

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
        _productCard = ProductCard(widget.products, widget._deleteProduct);
      }

      return Expanded(
        child: _productCard,
      );

    } catch (e) {
      return Container();
    }
  }
}
