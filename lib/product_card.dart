import 'package:flutter/material.dart';
import './models/product.dart';
import './widgets/product/price_tag.dart';
import './widgets/product/address_tag.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final Product product;
  final Function deleteProduct;

  ProductCard(this.id, this.product, this.deleteProduct);

  Widget productRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            product.title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        PriceTag(product.price),
      ],
    );
  }

  Widget actionButttons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.info),
          color: Theme.of(context).accentColor,
          onPressed: () =>
              Navigator.pushNamed<bool>(context, '/detail/' + id.toString())
                  .then((bool value) {
                print(value);
              }),
        ),
        IconButton(
          icon: Icon(Icons.favorite),
          color: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            margin: EdgeInsets.all(10.0),
            child: Image.network(product.imageUrl),
          ),
          Container(
            height: 60.0,
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: productRow(),
          ),
          AddressTag('Union Square, San Francisco'),
          Divider(),
          Container(
            margin: EdgeInsets.all(0.0),
            child: actionButttons(context),
          ),
        ],
      ),
    );
  }
}
