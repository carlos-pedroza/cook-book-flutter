import 'package:first_app/pages/tabs/product_edit_tab.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../scope_models/main_model.dart';

class ProductListTab extends StatefulWidget {
  bool isLoading = false;

  @override
  State<StatefulWidget> createState() {
    return ProductListTabState();
  }
}

class ProductListTabState extends State<ProductListTab> {
  Widget _buttonEditProduct(BuildContext context, int index, MainModel model) {
    return IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return ProductEditTab(model.allProducts[index]);
            }),
          ).then((dynamic value) {
            Navigator.pop(context);
          });
        });
  }

  Widget createList(BuildContext context, MainModel model) {
    if (widget.isLoading == true) {
      return CircularProgressIndicator();
    }
    if (model.allProducts.length == 0) {
      return Center(
        child: Text('No products'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key(model.allProducts[index].id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction) {
              if (direction == DismissDirection.endToStart) {
                setState(() {
                  widget.isLoading = true;
                  model.delete(model.allProducts[index].id).then((bool result) {
                    widget.isLoading = false;
                  });
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
                          NetworkImage(model.allProducts[index].imageUrl),
                    ),
                    title: Text(model.allProducts[index].title),
                    subtitle: Text('\$ ${model.allProducts[index].price}'),
                    trailing: _buttonEditProduct(context, index, model),
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: model.allProducts.length,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return createList(context, model);
      },
    );
  }
}
