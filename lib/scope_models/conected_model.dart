import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../models/user.dart';
import '../models/product.dart';
import '../enums/global.dart';

mixin ConectedModel on Model {
  List<Product> products = [];
  Uuid uuid = new Uuid();
  bool isFilterFavorite = false;

  bool _isLoading = false;
  bool get isLoading {
    return _isLoading;
  }

  set isLoading(bool value) {
    _isLoading = value;
  }

  User authUser;
  

  Future<bool> add(Product product) async {
    product.userID = authUser.id;
    product.userEmail = authUser.email;
    String uri = "https://flutter-products-9db8e.firebaseio.com/products.json";
    http.post(uri, body: product.toJson()).then((http.Response response) {
      var resp = jsonDecode(response.body);
      //var uuid = new Uuid();
      product.id = resp["name"]; //uuid.v1();
      products.add(product);
      notifyListeners();
      return true;
    });
  }

  Future<bool> update(Product editProduct) async {
    String url =
        "https://flutter-products-9db8e.firebaseio.com/products/${editProduct.id}.json?auth=${authUser.idToken}";
    http.put(url, body: editProduct.toJson()).then((http.Response response) {
      getHttpProducts().then((bool result) {
        notifyListeners();
        return true;
      });
    });
  }

  Future<bool> delete(String _id) async {
    products.removeWhere((Product p) => p.id == _id);
    String uri =
        "https://flutter-products-9db8e.firebaseio.com/products/${_id}.json?auth=${authUser.idToken}";
    http.delete(uri).then((http.Response resp) {
      getHttpProducts().then((bool result) {
        notifyListeners();
        return true;
      });
    });
  }

  clearProducts() {
    products = [];
  }

  Future<bool> getHttpProducts() async {
    clearProducts();
    isLoading = true;
    String uri = "https://flutter-products-9db8e.firebaseio.com/products.json?auth=${authUser.idToken}";
    http.get(uri).then((http.Response resp) {
      if (resp.statusCode == 200 || resp.statusCode == 201) {
        if (resp.body != "null") {
          Map<String, dynamic> mapProducts = jsonDecode(resp.body);
          mapProducts.forEach((String _id, dynamic _productMap) {
            Product product = Product.get(_productMap);
            product.id = _id;
            products.add(product);
          });
        }
        isLoading = false;
        notifyListeners();
        return true;
      }
    }).catchError((errorResult) {
      isLoading = false;
      notifyListeners();
      return false;
    });
  }

  launchTest() {
    /*add(Product(
        id: uuid.v1(),
        title: "Pulsera inteligente Xiaomi Mi Band 3, Negro",
        imageUrl:
            "https://images-na.ssl-images-amazon.com/images/I/516SRTkFwbL._SL1000_.jpg",
        description:
            "Capacidad Batería: 110 mAh (8 días en uso continuo), Pantalla táctil: Sí, Bluetooth 4.2, Color Negro, Con un diseño a prueba de agua de hasta 50 metros",
        price: 579.97));
    add(Product(
        id: uuid.v1(),
        title: "Microwave",
        imageUrl: "https://picsum.photos/id/0/500/200",
        description: "LG Silver",
        price: 550));
    add(Product(
        id: uuid.v1(),
        title: "Mercedes Bens",
        imageUrl: "https://picsum.photos/id/0/500/200",
        description: "A8",
        price: 150595.34));*/
  }
}
