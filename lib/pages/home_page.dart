import 'package:flutter/material.dart';
import '../product_manager.dart';
import '../product_control.dart';
import '../models/product.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final List<Product> products;
  Function _addProduct;
  Function _deleteProduct;

  HomePage(this.products, _addProduct, _deleteProduct);

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
                  child: ProductControl(widget._addProduct),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  tooltip: 'Search product',
                  onPressed: () {
                    setState(() {});
                  },
                ),
                Expanded(
                  child: Text('Items:' + widget.products.length.toString(),
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
            child: ProductManager(widget.products, widget._deleteProduct),
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
  }
}

class CustomlistTile extends StatelessWidget {
  IconData _icon;
  String _label;
  Function _onTap;

  CustomlistTile({icon: Icons.account_circle, label: "", onTap: Function}) {
    this._icon = icon;
    this._label = label;
    this._onTap = onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Row(
            children: <Widget>[
              Container(
                child: Icon(_icon),
                padding: EdgeInsets.all(16.0),
              ),
              Expanded(
                child: Container(
                  child: Text(_label),
                  padding: EdgeInsets.all(16.0),
                ),
              ),
              Container(
                child: Icon(Icons.arrow_right),
                padding: EdgeInsets.all(16.0),
              ),
            ],
          ),
          onTap: this._onTap,
        ),
        Divider(
          height: 1.0,
          color: Colors.grey,
        ),
      ],
    );
  }
}
