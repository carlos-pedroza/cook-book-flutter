import 'package:first_app/pages/product_delete_page.dart';
import 'package:flutter/material.dart';
import './pages/product_detail_page.dart';
import './models/product.dart';

class ProductCard extends StatelessWidget {
  final List<Product> products;
  final Function _deleteProduct;

  ProductCard(this.products, this._deleteProduct);

  final String imageUri = "https://picsum.photos/id/237/400/200";

  Widget _buildCard(BuildContext context, int index) {
    try {
      return Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Image.network(products[index].imageUrl),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Text(products[index].title),
            ),
            Container(
              margin: EdgeInsets.all(0.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Text('details'),
                    onPressed: () => Navigator.pushNamed<bool>(
                                context, '/detail/' + index.toString())
                            .then((bool value) {
                          print(value);
                        }),
                  ),
                  FlatButton(
                    child: Text('delete'),
                    onPressed: () =>
                        Navigator.pushNamed<bool>(context, '/delete')
                            .then((bool value) {
                          if (value != null) {
                            if (value == true) {
                              _deleteProduct(products[index]);
                            }
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _buildCard,
      itemCount: products.length,
    );
  }
}
