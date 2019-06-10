import 'package:flutter/material.dart';
import '../../models/product.dart';

class ProductCreateTab extends StatefulWidget {
  Function addProduct;

  ProductCreateTab(this.addProduct);

  @override
  State<StatefulWidget> createState() {
    return ProductCreateTabState();
  }
}

class ProductCreateTabState extends State<ProductCreateTab> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Product _product;

  @override
  void initState() {
    this._product =
        Product("", "https://picsum.photos/id/237/400/200", "", 0.0);
  }

  Widget productTitle() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Product title"),
      onSaved: (String value) {
        this._product.title = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return "Title is required!";
        }
      },
    );
  }

  Widget description() {
    return TextFormField(
      maxLines: 6,
      decoration: InputDecoration(labelText: "Description"),
      onSaved: (String value) {
        this._product.description = value;
      },
      validator: (String value) {
        if (value.isEmpty) {
          return "description is required!";
        }
      },
    );
  }

  Widget price() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Price"),
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
      widget.addProduct(this._product);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
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
      }
    );
  }
}
