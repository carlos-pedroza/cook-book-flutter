import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../utils/ensure-visible.dart';

class ProductEditTab extends StatefulWidget {
  final Function actionProduct;
  final Product _product;

  ProductEditTab(this.actionProduct, this._product);

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

  @override
  void initState() {
    if (widget._product != null) {
      this._product = Product(
          widget._product.id,
          widget._product.title,
          widget._product.imageUrl,
          widget._product.description,
          widget._product.price);
    } else {
      this._product =
          Product("", "", "https://picsum.photos/id/237/400/200", "", 0.0);
    }
  }

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

  Widget buttonSave() {
    return Container(
      margin: EdgeInsets.all(30.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('SAVE'),
        onPressed: () {
          saveProduct();
        },
      ),
    );
  }

  void saveProduct() {
    if (_formKey.currentState.validate() == true) {
      _formKey.currentState.save();
      widget.actionProduct(this._product);
      Navigator.pop(context);
    }
  }

  Widget editForm() {
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
                buttonSave(),
              ],
            ),
          ),
        ),
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        });
  }

  Widget editPage() {
      return Scaffold(
        appBar: AppBar(
          title: Text('Edit product'),
        ),
        body: editForm(),
      );
  }

  @override
  Widget build(BuildContext context) {
    if (widget._product != null) {
      return editPage();
    } else {
      return editForm();
    }
  }
}
