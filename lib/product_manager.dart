import "package:flutter/material.dart";
import 'package:scoped_model/scoped_model.dart';

import './ui_elements/product_card.dart';
import './scope_models/main_model.dart';
import 'dart:async';

class ProductManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  MainModel _model;
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        _model = model;
        return Expanded(
          child: mainContent(),
        );
      },
    );
  }

  Widget mainContent() {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      if (!model.isLoading) {
        return createProductCard();
      } else {
        return Center(child: CircularProgressIndicator());
      }
    });
  }

  Widget createProductCard() {
    return RefreshIndicator(
      child: productsContent(),
      onRefresh: _refreshList,
    );
  }

  Widget productsContent() {
    if (_model.mainProducts.length > 0) {
      return buildProduct();
    } else {
      return noProducts();
    }
  }

  Widget noProducts() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40.0),
          child: Text(
            'No products',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildProduct() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(_model.mainProducts[index], _model);
      },
      itemCount: _model.mainProducts.length,
    );
  }

  Future<Null> _refreshList() async {
    _model.isLoading = true;
    _model.getHttpProducts().then((bool result) {
      _model.isLoading = false;
      return null;
    });
  }
}
