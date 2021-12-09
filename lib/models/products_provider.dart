import 'package:flutter/material.dart';
import 'products_model.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _productsList = [
    Product(
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
    ),
  ];
  bool _onlyIsFavorite = false;

  List<Product> get productList {
    return [..._productsList];
  }

  void editProduct(Product newProduct, String id) {
    int index = _productsList.indexWhere((element) {
      return element.id == id;
    });

    _productsList[index] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _productsList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void addProduct(Product product) {
    var prod = Product(
        id: product.id,
        title: product.title,
        price: product.price,
        imageUrl: product.imageUrl,
        productDescription: product.productDescription);
    _productsList.insert(0, prod);
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
