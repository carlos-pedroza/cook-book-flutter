import 'package:first_app/models/product.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/services.dart';

import './pages/auth_page.dart';
import './pages/product_manager_page.dart';
import './pages/home_page.dart';
import './pages/register_page.dart';

import './pages/product_delete_page.dart';
import './pages/product_detail_page.dart';

import './scope_models/main_model.dart';

//import 'package:flutter/rendering.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: MainModel(),
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
          return MaterialApp(
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
                '/home': (BuildContext context) => HomePage(),
                '/admin': (BuildContext context) => ProductManagerPage(),
                '/register' : (BuildContext context) => RegisterPage()
              },
              onGenerateRoute: (RouteSettings settings) {
                final List<String> pathElements = settings.name.split('/');
                if (pathElements[0] != '') {
                  return null;
                }
                if (pathElements[1] == 'detail') {
                  final String _id = pathElements[2];
                  Product _product = model.get(_id);
                  if(_product != null) {
                    return MaterialPageRoute<bool>(
                      builder: (BuildContext context) =>
                          ProductDetailPage(_product),
                    );
                  }
                } else if (pathElements[1] == 'delete') {
                  return MaterialPageRoute<bool>(
                    builder: (BuildContext context) => ProductDeletePage(),
                  );
                }
                return null;
              });
        },
      ),
    );
  }
}