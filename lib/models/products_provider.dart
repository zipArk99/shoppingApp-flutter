import 'package:flutter/material.dart';
import 'package:shop/models/https_exception.dart';
import 'products_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  final url = Uri.https(
      'flutter-shop-1c708-default-rtdb.firebaseio.com', '/products.json');

  List<Product> _productsList = [
    /*   Product(
      id: 'p1',
      title: 'Red Shirt',
      productDescription: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      productDescription: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      productDescription:
          'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      productDescription: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ), */
  ];
  bool _onlyIsFavorite = false;

  List<Product> get productList {
    return [..._productsList];
  }

  Future<void> editProduct(Product newProduct, String id) async {
    int index = _productsList.indexWhere((element) {
      return element.id == id;
    });
    try {
      var url = Uri.https('flutter-shop-1c708-default-rtdb.firebaseio.com',
          '/products/$id.json');

      await http.patch(
        url,
        body: json.encode(
          {
            'title': newProduct.title,
            'price': newProduct.price,
            'imageUrl': newProduct.imageUrl,
            'productDescription': newProduct.productDescription
          },
        ),
      );
    } catch (error) {
      throw error;
    }
    _productsList[index] = newProduct;
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    var url = Uri.https(
        'flutter-shop-1c708-default-rtdb.firebaseio.com', '/products/$id.json');

    var tempIndex = productList.indexWhere((element) => element.id == id);
    var tempProduct = productList.elementAt(tempIndex);

    var response = await http.delete(url);
    _productsList.removeWhere((element) => element.id == id);

    if (response.statusCode >= 400) {
      _productsList.insert(tempIndex, tempProduct);
      print(response.statusCode);
      throw HttpsException("operation failed");
    } else {
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'price': product.price,
            'imageUrl': product.imageUrl,
            'productDescription': product.productDescription,
            'isFavorite': product.isFavorite
          },
        ),
      );

      var prod = Product(
          id: json.decode(response.body)['name'],
          title: product.title,
          price: product.price,
          imageUrl: product.imageUrl,
          productDescription: product.productDescription);
      _productsList.insert(0, prod);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(url);
      var responeData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> tempProducts = [];
      responeData.forEach((prodId, prodValue) {
        tempProducts.add(Product(
          id: prodId,
          title: prodValue['title'],
          price: prodValue['price'],
          imageUrl: prodValue['imageUrl'],
          productDescription: prodValue['productDescription'],
          isFavorite: prodValue['isFavorite'],
        ));
      });
      _productsList = tempProducts;
    } catch (error) {
      print(error);
      throw error;
    }
    notifyListeners();
  }

  List<Product> get onlyIsFavoriteFun {
    return _productsList.where((element) {
      return element.isFavorite;
    }).toList();
  }

  Product getSingleProduct(String productId) {
    return _productsList.firstWhere(
      (element) {
        return element.id == productId;
      },
    );
  }
}
