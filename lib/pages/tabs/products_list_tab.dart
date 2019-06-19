import 'package:first_app/pages/tabs/product_edit_tab.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scope_models/products_model.dart';

class ProductListTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductListTabState();
  }

}

class ProductListTabState extends State<ProductListTab> {
  Widget _buttonEditProduct(
      BuildContext context, int index, ProductsModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductEditTab(model.products[index]);
            }),
          );
        });
  }

  Widget createList(BuildContext context, ProductsModel model) {
    if (model.products.length == 0) {
      return Center(
        child: Text('No products'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.products[index].id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  model.delete(model.products[index].id);
                });
              }
            },
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(model.products[index].imageUrl),
                    ),
                    title: Text(model.products[index].title),
                    subtitle: Text('\$ ${model.products[index].price}'),
                    trailing: _buttonEditProduct(context, index, model),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: model.products.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model) {
        return createList(context, model);
      },
    );
  }
}
