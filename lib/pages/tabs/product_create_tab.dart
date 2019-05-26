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
  Product _product =
      Product("", "https://picsum.photos/id/237/400/200", "", 0.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "Product title"),
            onChanged: (String value) {
              setState(() {
                _product.title = value;
              });
            },
          ),
          TextField(
            maxLines: 6,
            decoration: InputDecoration(labelText: "Description"),
            onChanged: (String value) {
              setState(() {
                _product.description = value;
              });
            },
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: "Price"),
            onChanged: (String value) {
              setState(() {
                _product.price = double.parse(value);
              });
            },
          ),
          Container(
            margin: EdgeInsets.all(30.0),
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              child: Text('SAVE'),
              onPressed: () {
                widget.addProduct(this._product);
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
