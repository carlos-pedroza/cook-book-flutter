import 'package:flutter/material.dart';
import './pages/auth_page.dart';
import './pages/product_manager_page.dart';
import './pages/product_detail_page.dart';
import './pages/home_page.dart';
import './pages/product_delete_page.dart';
import './models/product.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<Product> products = [];

  void _addProduct(Product product) {
    setState(() {
      this.products.add(product);
      //debugger(when: _products.length > 2);
    });
  }

  void _deleteProduct(Product product) {
    setState(() {
      this.products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //debugShowMaterialGrid: true,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColorDark: Colors.deepOrange,
          primaryColorLight: Color.fromRGBO(255, 204, 188, 1),
          primaryColor: Color.fromRGBO(255, 87, 34, 1),
          accentColor: Colors.lightGreen,
          dividerColor: Color.fromRGBO(189, 189, 189, 1)),
      routes: {
        '/': (BuildContext context) => AuthPage(),
        '/home': (BuildContext context) =>
            HomePage(products, _addProduct, _deleteProduct),
        '/admin': (BuildContext context) => ProductManagerPage(_addProduct)
      },
      onGenerateRoute: (RouteSettings settings) {
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != '') {
          return null;
        }
        if (pathElements[1] == 'detail') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductDetailPage(
                  products[index].title,
                  products[index].imageUrl,
                ),
          );
        } else if (pathElements[1] == 'delete') {
          return MaterialPageRoute<bool>(
            builder: (BuildContext context) => ProductDeletePage(),
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                HomePage(products, _addProduct, _deleteProduct));
      },
    );
  }
}
