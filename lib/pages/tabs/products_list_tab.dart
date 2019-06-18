import 'package:first_app/pages/tabs/product_edit_tab.dart';
import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductListTab extends StatelessWidget {
  final Function _updateProduct;
  final Function _deleteProduct;
  final List<Product> _products;

  ProductListTab(this._updateProduct, this._deleteProduct, this._products);

  Widget _buttonEditProduct(BuildContext context, int index) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductEditTab(_updateProduct, _products[index]);
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (_products.length == 0) {
      return Center(
        child: Text('No products'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(_products[index].id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                _deleteProduct(_products[index]);
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_products[index].imageUrl),
                    ),
                    title: Text(_products[index].title),
                    subtitle: Text('\$ ${_products[index].price}'),
                    trailing: _buttonEditProduct(context, index),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: _products.length,
      );
    }
  }
}
