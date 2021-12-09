import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final String productDescription;
  bool isFavorite;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.imageUrl,
      required this.productDescription,
      this.isFavorite = false}) {
    print("Product constructor called");
  }

  void setIsFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
