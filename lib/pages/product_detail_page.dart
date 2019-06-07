import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product/price_tag.dart';

class ProductDetailPage extends StatefulWidget {
  final Product _product;

  ProductDetailPage(this._product);

  @override
  State<StatefulWidget> createState() {
    return ProductDetailState();
  }
}

class ProductDetailState extends State<ProductDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(61, 71, 83, 1),
        appBar: AppBar(
          title: Text('Product detail'),
        ),
        body: Container(
          padding: EdgeInsets.all(30.0),
          child: Center(
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image.network(widget._product.imageUrl),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 8.0, left: 16.0, right: 16.0, bottom: 8.0),
                    child: Text(
                      widget._product.title,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(widget._product.description),
                    ),
                  ),
                  Divider(),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                    child: PriceTag(widget._product.price),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
