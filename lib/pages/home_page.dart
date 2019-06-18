import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scope_models/products_model.dart';
import '../product_manager.dart';
import '../product_control.dart';

import '../utils/custom_list_tile.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void onTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return ScopedModelDescendant<ProductsModel>(
        builder: (BuildContext context, Widget child, ProductsModel model) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(61, 71, 83, 1),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        child: Padding(
                          padding: EdgeInsets.all(14),
                          child: Image.asset(
                            'assets/images/flutter_ico.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 3,
                        ),
                        child: Text('Flutter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      Theme.of(context).primaryColorDark,
                      Theme.of(context).primaryColorLight,
                    ],
                  ),
                ),
              ),
              CustomlistTile(
                icon: Icons.add_box,
                label: 'Products show',
                onTap: () {
                  Navigator.pushNamed(context, '/admin').then((Object value) {
                    Navigator.pop(context);
                  });
                },
              ),
              CustomlistTile(
                icon: Icons.share,
                label: 'Share',
                onTap: () {},
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text('Product show'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ProductControl(),
                  ),
                  IconButton(
                    icon: Icon(Icons.search),
                    tooltip: 'Search product',
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  Expanded(
                    child: Text('Items:' + model.products.length.toString(),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: Border.all(
                    color: Colors.blueGrey,
                    width: 1.0,
                  )),
            ),
            Container(
              child: ProductManager(),
            )
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.deepOrange,
            unselectedItemColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                title: Text('Business'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up),
                title: Text('School'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.lightBlueAccent,
            onTap: onTap),
      );
    });
  }
}
