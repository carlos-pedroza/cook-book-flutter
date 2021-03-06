import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/product.dart';
import './conected_model.dart';

mixin ProductsModel on ConectedModel {

  List<Product> get allProducts {
    return List.from(products);
  }

  List<Product> get mainProducts {
    return !isFilterFavorite
        ? allProducts
        : List.from(products.where((p) => p.isFavorite));
  }



  Product get(String _id) {
    return products.firstWhere((Product _product) => _product.id == _id,
        orElse: () => null);
  }

  Product preparedProduct({Product product}) {
    if (product == null) {
      String productImage =
          "https://images-na.ssl-images-amazon.com/images/I/81fdRep8ucL._SL1500_.jpg";
      return Product(
          id: "",
          title: "",
          description: "",
          imageUrl: productImage,
          price: 0.0);
    } else {
      return Product(
          id: product.id,
          title: product.title,
          imageUrl: product.imageUrl,
          description: product.description,
          price: product.price);
    }
  }

  toggleFavorite(String _id) {
    Product product =
        products.firstWhere((Product p) => p.id == _id, orElse: () => null);
    product.isFavorite = !product.isFavorite;
  }

  toggleFilterFavorite() {
    isFilterFavorite = !isFilterFavorite;
  }
}
