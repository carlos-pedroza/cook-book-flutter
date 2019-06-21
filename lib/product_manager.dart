import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './product_card.dart';
import './scope_models/main_model.dart';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Expanded(
          child: createProductCard(context, model),
        );
      },
    );
  }

  Widget createProductCard(BuildContext context, MainModel model) {
    if (model.mainProducts.length > 0) {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(model.mainProducts[index], model);
        },
        itemCount: model.mainProducts.length,
      );
    } else {
      return Center(
        child: Text('No products!'),
      );
    }
  }
}
