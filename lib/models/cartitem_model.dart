import 'package:flutter/material.dart';

class CartItem {
  final String cartItemId;
  final String title;
  final double price;
  int quantity;

  CartItem(
      {required this.cartItemId,
      required this.title,
      required this.price,
      required this.quantity});

  Map toJson() => {
        'CartItemId': cartItemId,
        'title': title,
        'price': price,
        'quantity': quantity,
      };
}

class Cart with ChangeNotifier {
  int itemCounter = 0;

  Map<String, CartItem> _item = {};

  Map<String, CartItem> get item {
    return {..._item};
  }

  double get total {
    double totalNum = 0.0;

    for (int i = 0; i < item.length; i++) {
      totalNum +=
          item.values.toList()[i].price * item.values.toList()[i].quantity;
    }
    return totalNum;
  }

  void removeItem(String productId) {
    _item.remove(productId) as CartItem;
    notifyListeners();
  }

  void removeCartItem(String productId) {
    if (_item[productId]!.quantity > 1) {
      _item.update(productId, (value) {
        return CartItem(
            cartItemId: value.cartItemId,
            title: value.title,
            price: value.price,
            quantity: value.quantity - 1);
      });
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void addItem(String productId, String productTitle, double productPrice) {
    itemCounter++;
    _item.update(productId, (value) {
      print("updatecalled");
      return CartItem(
          cartItemId: value.cartItemId,
          title: value.title,
          price: value.price,
          quantity: value.quantity + 1);
    }, ifAbsent: () {
      print("ifAbsentCalled");
      return CartItem(
          cartItemId: DateTime.now().toString(),
          title: productTitle,
          price: productPrice,
          quantity: 1);
    });

    notifyListeners();
  }

  bool checkAvailability(String id) {
    return item.containsKey(id);
  }

  get emptyCart {
    _item.clear();
    notifyListeners();
  }

  bool get checkEmpty {
    return _item.isEmpty;
  }
}


  /* if (item.containsKey(productId)) {
      item.update(productId, (value) {
        return CartItem(
            cartItemId: productId,
            title: productTitle,
            price: productPrice,
            quantity: quantity + 1);
      });
    } else {
      item.putIfAbsent(productId, 
        CartItem(
            cartItemId: productId,
            title: productTitle,
            price: productPrice,
            quantity: 1);
      );
    } */


    /*  List<CartItem> item = [];

  void addItem(String productId, String productTitle, double productPrice) {
    item.map((element) {
      if (element.cartItemId != productId) {
        print("new");
        item.add(CartItem(
            cartItemId: productId,
            title: productTitle,
            price: productPrice,
            quantity: 1));
        return;
      }
    });
    var index = item.indexWhere((element) {
      return element.cartItemId == productId;
    });

    item[index].quantity++;
    print(quantity);*/
