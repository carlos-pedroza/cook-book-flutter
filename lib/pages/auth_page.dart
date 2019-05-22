import 'package:flutter/material.dart';
import '../pages/home_page.dart';

class AuthPage extends StatelessWidget {
  final List<Map<String, String>> products;

  AuthPage(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products managament', textAlign: TextAlign.center,),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('LOGIN'),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
      ),
    );
  }
}
