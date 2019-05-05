import "package:flutter/material.dart";
import './product_card.dart';

class ProductManager extends StatefulWidget {
  final String startingProduct;

  ProductManager({this.startingProduct = 'Default product'}) {
    print("[contructor ProductManager]");
  }

  @override
  State<StatefulWidget> createState() {
    print("[create state ProductManager]");
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  List<String> _products = [];

  @override
  void initState() {
     print("[init state ProductManager]");
    super.initState();
    this._products.add(widget.startingProduct);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () {
                setState(() {
                   print("[set state ProductManager]");
                  _products.add('new peoduct');
                });
              },
              child: Text('Add product'),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.1),
            child: ProductCard(_products), //must sustitud by producs cards
          ),
        ],
      ),
    );
  }
}
