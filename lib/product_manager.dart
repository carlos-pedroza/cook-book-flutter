import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import './scope_models/products_model.dart';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return Expanded(
          child: createProductCard(context, model),
        );
      },
    );
  }

  Widget createProductCard(BuildContext context, ProductsModel model) {
    if (model.products.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(index, model.products[index], model.deleteProduct);
        },
        itemCount: model.products.length,
      );
    } else {
      return Center(
        child: Text('No products!'),
      );
    }
  }
}
