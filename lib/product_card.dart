import 'package:flutter/material.dart';
import './pages/product_detail_page.dart';

class ProductCard extends StatelessWidget {
  final List<String> products;
  ProductCard(this.products);

  Widget _buildCard(BuildContext context, int index) {
    try {
      return Card(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Image.asset('assets/food.jpg'),
            ),
            Container(
              margin: EdgeInsets.all(5.0),
              child: Text(products[index]),
            ),
            Container(
              margin: EdgeInsets.all(0.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.start,
                children: <Widget>[
                  FlatButton(
                    child: Text('details'),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              ProductDetailPage(),
                        )),
                  ),
                  FlatButton(
                    child: Text('delete'),
                    onPressed: () => {},
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
