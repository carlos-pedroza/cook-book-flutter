import 'package:flutter/material.dart';
//import '../service.dart';
import '../product_manager.dart';
import '../product_control.dart';
import '../pages/product_manager_page.dart';
import '../models/product.dart';

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
  void initState() {
    super.initState();
    //Service service = Service();
    //products = service.GetProducts();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;

    void onTap(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            AppBar(
              automaticallyImplyLeading: false,
              title: Text('choose'),
            ),
            ListTile(
              title: Text('Products show'),
              onTap: () {
                Navigator.pushNamed(context, '/admin').then((Object value) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Product show'),
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
