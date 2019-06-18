import 'package:flutter/material.dart';

import '../pages/tabs/product_edit_tab.dart';
import '../pages/tabs/products_list_tab.dart';
import '../models/product.dart';

class ProductManagerPage extends StatefulWidget {
  List<Product> _products;
  Function addProduct;
  Function updateProduct;
  Function deleteProduct;

  ProductManagerPage(this.addProduct, this.updateProduct, this.deleteProduct, this._products);

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
            ProductEditTab(widget.addProduct, null),
            ProductListTab(widget.updateProduct, widget.deleteProduct,  widget._products),
          ],
        ),
      ),
    );
  }
}
