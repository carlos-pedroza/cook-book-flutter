import 'package:flutter/material.dart';

class Product {
  String id;
  String title;
  String imageUrl;
  String description;
  double price;
  bool isFavorite;

  Product(
      {this.id = "",
      @required this.title,
      @required this.imageUrl,
      @required this.description,
      @required this.price,
      this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "image_url": imageUrl,
      "description": description,
      "price": price
    };
  }
}
