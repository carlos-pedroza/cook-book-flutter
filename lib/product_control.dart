import "package:flutter/material.dart";
import "./models/product.dart";


class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return TextField(onChanged: (value) {},);
  }
}
