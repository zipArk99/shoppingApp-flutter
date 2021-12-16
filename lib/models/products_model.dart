import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/https_exception.dart';

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

  Future<void> setIsFavorite() async {
    isFavorite = !isFavorite;
    print("id::::::::::;" + id);
    var url = Uri.https(
        'flutter-shop-1c708-default-rtdb.firebaseio.com', '/products/$id.json');
    var response = await http.patch(
      url,
      body: json.encode(
        {'isFavorite': isFavorite},
      ),
    );
    if (response.statusCode >= 400) {
      print("error occured::" + response.statusCode.toString());
      isFavorite = !isFavorite;
      throw HttpsException("error ------- occured");
    }

    notifyListeners();
  }
}
