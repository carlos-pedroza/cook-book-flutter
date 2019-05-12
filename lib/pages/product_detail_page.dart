import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product detail'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Image.network('https://picsum.photos/id/237/200/300'),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Product Name:'),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: RaisedButton(
              color: Theme.of(context).accentColor,
              child: Text('Close'),
              onPressed: () => Navigator.pop(context),
            ),
          )
        ],
      )),
    );
  }
}
