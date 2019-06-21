import 'package:flutter/material.dart';
import 'dart:convert';

class Product {
  String id;
  String title;
  String imageUrl;
  String description;
  double price;
  bool isFavorite;
  String userID;
  String userEmail;

  Product(
      {this.id = "",
      @required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.price,
      this.userID,
      this.userEmail,
      this.isFavorite = false});

  String toJson() {
    return jsonEncode({
      "title": title,
      "description": description,
      "imageUrl": imageUrl,
      "price": price,
      "userID": userID,
      "userEmail": userEmail,
      "isFavorite": isFavorite
    });
  }

  static Product get(Map<String,dynamic> productMap) {
    return Product(
        id: productMap["id"],
        title: productMap["title"],
        description: productMap["description"],
        imageUrl: productMap["imageUrl"],
        price: (productMap["price"] is double) ? productMap["price"] as double : (productMap["price"] as int).toDouble() ,
        userID: productMap["userID"]!=null ? productMap["userID"] : "",
        userEmail: productMap["userEmail"]!=null ? productMap["userEmail"] : "",
        isFavorite: productMap["isFavorite"]!=null ? productMap["isFavorite"] as bool : false);
  }
}
