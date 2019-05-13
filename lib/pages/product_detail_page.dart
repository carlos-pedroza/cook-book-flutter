import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {

  final String title;
  final String imageUri;

  ProductDetailPage(this.title, this.imageUri);

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
          Image.network(widget.imageUri),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text('Product Name:' + widget.title),
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
