import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../scope_models/products_model.dart';
import '../../models/product.dart';
import '../../utils/ensure-visible.dart';
import '../../scope_models/main_model.dart';

class ProductEditTab extends StatefulWidget {
  final Product _product;
  ProductEditTab(this._product);

  @override
  State<StatefulWidget> createState() {
    return ProductEditTabState();
  }
}

class ProductEditTabState extends State<ProductEditTab> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Product _product;
  var titleFocusNode = FocusNode();
  var descriptionFocusNode = FocusNode();
  var priceFocusNode = FocusNode();

  Widget productTitle() {
    return EnsureVisibleWhenFocused(
      focusNode: titleFocusNode,
      child: TextFormField(
        decoration: InputDecoration(labelText: "Product title"),
        initialValue: widget._product != null ? widget._product.title : "",
        onSaved: (String value) {
          this._product.title = value;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return "Title is required!";
          }
        },
      ),
    );
  }

  Widget description() {
    return EnsureVisibleWhenFocused(
      focusNode: descriptionFocusNode,
      child: TextFormField(
        maxLines: 6,
        decoration: InputDecoration(labelText: "Description"),
        initialValue:
            widget._product != null ? widget._product.description : "",
        onSaved: (String value) {
          this._product.description = value;
        },
        validator: (String value) {
          if (value.isEmpty) {
            return "description is required!";
          }
        },
      ),
    );
  }

  Widget price() {
    return EnsureVisibleWhenFocused(
      focusNode: priceFocusNode,
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: "Price"),
        initialValue:
            widget._product != null ? widget._product.price.toString() : "",
        onSaved: (String value) {
          this._product.price = double.parse(value);
        },
        validator: (String value) {
          if (value.isEmpty) {
            return "The price is required!";
          }
          if (!RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
            return 'The price should be a number';
          }
          if (double.parse(value) <= 0) {
            return "The price should be greater than zero!";
          }
        },
      ),
    );
  }

  Widget getButtonContent = Text(
    'SAVE',
    style: TextStyle(
      fontSize: 20.0,
    ),
  );

  buttonNormal() {
    getButtonContent = Text(
      'SAVE',
      style: TextStyle(
        fontSize: 20.0,
      ),
    );
  }

  buttonLoading() {
    getButtonContent = Row(
      children: <Widget>[
        Expanded(
          child: Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'SAVING',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonSave(BuildContext context, ProductsModel model) {
    return Container(
      margin: EdgeInsets.all(30.0),
      height: 60.0,
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: getButtonContent,
        onPressed: () {
          saveProduct(context, model);
        },
      ),
    );
  }

  void saveProduct(BuildContext context, ProductsModel model) {
    if (_formKey.currentState.validate() == true) {
      _formKey.currentState.save();
      setState(() {
        buttonLoading();
        if (this._product.id == "") {
          model.add(this._product).then((bool result) {
            buttonNormal();
            Navigator.pop(context);
          });
        } else {
          model.update(this._product).then((bool result) {
            buttonNormal();
            Navigator.pop(context);
          });
        }
      });
    }
  }

  Widget formWidget(BuildContext context, ProductsModel model) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  child: Text(
                    'PRODUCT',
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(50.0),
                ),
                productTitle(),
                description(),
                price(),
                buttonSave(context, model),
              ],
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        });
  }

  Widget editPage(BuildContext context, ProductsModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product'),
      ),
      body: formWidget(context, model),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      _product = model.preparedProduct(
        product: widget._product,
      );
      return createEditWidget(context, model);
    });
  }

  Widget createEditWidget(BuildContext context, ProductsModel model) {
    if (widget._product.id != "") {
      return editPage(context, model);
    } else {
      return formWidget(context, model);
    }
  }
}
