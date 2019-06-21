import 'package:first_app/scope_models/products_model.dart';
import 'package:flutter/material.dart';
import './models/product.dart';
import './widgets/product/price_tag.dart';
import './widgets/product/address_tag.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final ProductsModel model;

  ProductCard(this.product, this.model);

  @override
  State<StatefulWidget> createState() {
    return ProductCardState();
  }

}

class ProductCardState extends State<ProductCard> {
  Widget productRow() {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            widget.product.title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        PriceTag(widget.product.price),
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
              Navigator.pushNamed<bool>(context, '/detail/' + widget.product.id)
                  .then((bool value) {
                print(value);
              }),
        ),
        IconButton(
          icon: Icon(Icons.favorite),
          color: widget.product.isFavorite ? Colors.red : Colors.blueGrey,
          onPressed: () {
            setState(() {
              widget.model.toggleFavorite(widget.product.id);
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = widget.product.imageUrl;
    return Card(
      margin: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 200.0,
            margin: EdgeInsets.all(10.0),
            child: Image(image: NetworkImage(imageUrl),),
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
