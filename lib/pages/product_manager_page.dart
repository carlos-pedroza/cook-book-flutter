import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../pages/tabs/product_edit_tab.dart';
import '../pages/tabs/products_list_tab.dart';

import '../scope_models/products_model.dart';

class ProductManagerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductManagePageState();
  }
}

class ProductManagePageState extends State<ProductManagerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Product manager'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.create),
                text: 'Create Product',
              ),
              Tab(icon: Icon(Icons.list), text: 'My products')
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            ScopedModelDescendant(builder: (BuildContext context, Widget child, ProductsModel model) {
              return ProductEditTab(model.create());
            }),
            ProductListTab(),
          ],
        ),
      ),
    );
  }
}
