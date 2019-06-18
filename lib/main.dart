import 'package:flutter/material.dart';
import './pages/auth_page.dart';
import './pages/product_manager_page.dart';
import './pages/product_detail_page.dart';
import './pages/home_page.dart';
import './pages/product_delete_page.dart';
import './models/product.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

//import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  List<Product> products = [];
  var uuid = new Uuid();

  MyApp() {
    products.add(Product(
        uuid.v1(),
        "Pulsera inteligente Xiaomi Mi Band 3, Negro",
        "https://images-na.ssl-images-amazon.com/images/I/516SRTkFwbL._SL1000_.jpg",
        "Capacidad Batería: 110 mAh (8 días en uso continuo), Pantalla táctil: Sí, Bluetooth 4.2, Color Negro, Con un diseño a prueba de agua de hasta 50 metros",
        579.97));
    products.add(Product(uuid.v1(), "Microwave",
        "https://picsum.photos/id/0/500/200", "LG Silver", 550));
    products.add(Product(uuid.v1(), "Mercedes Bens",
        "https://picsum.photos/id/0/500/200", "A8", 150595.34));
  }

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  void _addProduct(Product product) {
    setState(() {
      product.id = widget.uuid.v1();
      widget.products.add(product);
      //debugger(when: _products.length > 2);
    });
  }
  void _updateProduct(Product editProduct) {
    Product product = widget.products.firstWhere((Product _product)=>_product.id==editProduct.id, orElse: () => null);
    product.title = editProduct.title;
    product.description = editProduct.description;
    product.imageUrl = editProduct.imageUrl;
    product.price = editProduct.price;
  }

  void _deleteProduct(Product product) {
    setState(() {
      widget.products.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget materiaApp = MaterialApp(
        //debugShowMaterialGrid: true,
        theme: ThemeData(
            fontFamily: 'Verdana, Geneva, sans-serif',
            brightness: Brightness.light,
            primaryColorDark: Colors.deepOrange,
            primaryColorLight: Color.fromRGBO(255, 204, 188, 1),
            primaryColor: Color.fromRGBO(255, 87, 34, 1),
            accentColor: Colors.lightGreen,
            dividerColor: Color.fromRGBO(189, 189, 189, 1)),
        routes: {
          '/': (BuildContext context) => AuthPage(),
          '/home': (BuildContext context) =>
              HomePage(widget.products, _addProduct, _deleteProduct),
          '/admin': (BuildContext context) =>
              ProductManagerPage(_addProduct,_updateProduct, _deleteProduct, widget.products)
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split('/');
          if (pathElements[0] != '') {
            return null;
          }
          if (pathElements[1] == 'detail') {
            final int index = int.parse(pathElements[2]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) =>
                  ProductDetailPage(widget.products[index]),
            );
          } else if (pathElements[1] == 'delete') {
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => ProductDeletePage(),
            );
          }
          return null;
        });

    /*if (MediaQuery.of(materiaApp).size.width >
            MediaQuery.of(materiaApp.context).size.height &&
        MediaQuery.of(materiaApp.context).size.width > 600.0) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
          .then((_) {});
    }*/

    return materiaApp;
  }
}
