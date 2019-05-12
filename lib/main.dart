import 'package:flutter/material.dart';
import './pages/home_page.dart';

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
      home: HomePage()
    );
  }
}
