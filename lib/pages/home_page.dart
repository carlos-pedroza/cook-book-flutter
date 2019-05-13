import 'package:flutter/material.dart';
//import '../service.dart';
import '../product_manager.dart';
import '../product_control.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<HomePage> {
  List<Map<String, String>> products = [];

  int _selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //Service service = Service();
    //products = service.GetProducts();
  }

  void _addProduct(Map product) {
    setState(() {
      products.add(product);
      //debugger(when: _products.length > 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Easy List'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    "Test App",
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: ProductControl(_addProduct),
                ),
                Expanded(
                  child: Text('Items:' + products.length.toString(),
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
            child: ProductManager(products),
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
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.lightBlueAccent,
          onTap: onTap),
    );
  }
}
