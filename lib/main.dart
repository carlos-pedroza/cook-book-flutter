import 'package:flutter/material.dart';
import './product_manager.dart';
import "./product_control.dart";

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
  List<String> products = [];

  void _addProduct(String product) {
    setState(() {
      products.add(product);
      //debugger(when: _products.length > 2);
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
        home: Scaffold(
            appBar: AppBar(
              title: Text('Easy List'),
            ),
            body: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: ProductControl(_addProduct),
                ),
                Container(
                  child: ProductManager(products),
                )
              ],
            )));
  }
}
