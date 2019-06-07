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
  final Product _product =
      Product("", "https://picsum.photos/id/237/400/200", "", 0.0);

  Widget productTitle() {
    return TextField(
      decoration: InputDecoration(labelText: "Product title"),
      onChanged: (String value) {
        setState(() {
          _product.title = value;
        });
      },
    );
  }

  Widget description() {
    return TextField(
      maxLines: 6,
      decoration: InputDecoration(labelText: "Description"),
      onChanged: (String value) {
        setState(() {
          _product.description = value;
        });
      },
    );
  }

  Widget price() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Price"),
      onChanged: (String value) {
        setState(() {
          _product.price = double.parse(value);
        });
      },
    );
  }

  Widget buttonSave() {
    /* return Container(
      margin: EdgeInsets.all(30.0),
      child: RaisedButton(
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text('SAVE'),
        onPressed: () {
          saveProduct(_product);
        },
      ),
    );*/

    return GestureDetector(
      onTap: () {
        saveProduct(_product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorDark,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        margin: EdgeInsets.all(10.0),
        padding: EdgeInsets.all(5),
        child: Text(
          'SAVE',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  void saveProduct(Product _product) {
    widget.addProduct(_product);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: ListView(
        children: <Widget>[
          productTitle(),
          description(),
          price(),
          buttonSave(),
        ],
      ),
    );
  }
}
