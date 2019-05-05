import 'package:flutter/material.dart';
import './product_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}
class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColorDark: Colors.deepOrange,
        primaryColorLight: Color.fromRGBO(255, 204, 188, 1),
        primaryColor: Color.fromRGBO(255, 87, 34, 1),
        accentColor: Colors.lightGreen,
        dividerColor: Color.fromRGBO(189, 189, 189, 1)
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Easy List'),
          ),
          body: ProductManager(startingProduct: 'Tester sample'),
    ));
  }
}
