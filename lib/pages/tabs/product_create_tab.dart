import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductCreateTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductCreateTabState();
  }
}

class ProductCreateTabState extends State<ProductCreateTab> {
  Product _product = Product("", "", "", 0.0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value) {
            setState(() {
              _product.title = value;
            });
          },
        ),
        TextField(
          maxLines: 4,
          onChanged: (String value) {
            setState(() {
              _product.description = value;
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          onChanged: (String value) {
            setState(() {
              _product.price = double.parse(value);
            });
          },
        ),
      ],
    );
  }
}
