import 'package:flutter/material.dart';

class ProductDeletePage extends StatelessWidget {
  _deleteProduct(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Are you sure'),
            content: Text('this connot be undone'),
            actions: <Widget>[
              FlatButton(
                child: Text('DISCARD'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text('CONTINUE'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("products delete"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Text("Delete product?"),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      child: Text("Yes"),
                      onPressed: () => _deleteProduct(
                          context), //Navigator.pop(context, true),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: RaisedButton(
                      child: Text("No"),
                      onPressed: () => Navigator.pop(context, false),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
