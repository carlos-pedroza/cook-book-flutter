import "package:flutter/material.dart";


class ProductControl extends StatelessWidget {
  final Function addProduct;

  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        addProduct({ "title": "Text sample " + DateTime.now().toString(), "image-url": "https://picsum.photos/id/237/400/200" });
      },
      child: Text('Add product'),
    );
  }
}
