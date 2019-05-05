import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final List<String> products;
  ProductCard(this.products);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: products
          .map(
            (element) => Card(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20.0),
                        child: Image.asset('assets/food.jpg'),
                      ),
                      Container(
                        margin: EdgeInsets.all(20.1),
                        child: Text(element),
                      ),
                    ],
                  ),
                ),
          )
          .toList(),
    );
  }
}
