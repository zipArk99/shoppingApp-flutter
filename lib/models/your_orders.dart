import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/cartitem_model.dart' as Ci;
import 'package:http/http.dart' as http;
import 'package:shop/models/https_exception.dart';

class YourOrder {
  final String orderId;
  final double totalPrice;
  final List<Ci.CartItem> order;
  final DateTime orderTime;

  YourOrder(
      {required this.orderId,
      required this.totalPrice,
      required this.order,
      required this.orderTime});
}

class YourOrderList with ChangeNotifier {
  List<YourOrder> _yourOrderList = [];

  List<YourOrder> get yourOrderList {
    return [..._yourOrderList];
  }

  Future<void> fetchYourOrders() async {
    final url = Uri.https(
        'flutter-shop-1c708-default-rtdb.firebaseio.com', '/orders.json');
    List<YourOrder> tempYourOrder = [];

    var response = await http.get(url);
    var decodedJson = json.decode(response.body);
    if (response.statusCode >= 400 || decodedJson == null) {
      return;
    }

    decodedJson.forEach((key, value) {
      tempYourOrder.add(
        YourOrder(
          orderId: key,
          totalPrice: value['totalPrice'],
          order: (value['order'] as List<dynamic>).map((element) {
            return Ci.CartItem(
                cartItemId: element['cartItemId'],
                title: element['title'],
                price: element['price'],
                quantity: element['quantity']);
          }).toList(),
          orderTime: DateTime.parse(value['orderTime']),
        ),
      );
    });

    _yourOrderList = tempYourOrder.reversed.toList();
    notifyListeners();
  }

  Future<void> addYourOrder(double totalPrice, List<Ci.CartItem> order) async {
    try {
      var url = Uri.https(
          'flutter-shop-1c708-default-rtdb.firebaseio.com', '/orders.json');

      String jsonDate = DateTime.now().toString();
      var respo = await http.post(
        url,
        body: json.encode(
          {
            'totalPrice': totalPrice,
            'orderTime': jsonDate,
            'order': order
                .map((element) => {
                      'cartItemId': element.cartItemId,
                      'title': element.title,
                      'quantity': element.quantity,
                      'price': element.price
                    })
                .toList(),
          },
        ),
      );

      _yourOrderList.add(YourOrder(
          orderId: json.decode(respo.body)['name'],
          totalPrice: totalPrice,
          order: order,
          orderTime: DateTime.now()));
    } catch (error) {
      throw HttpsException(error.toString());
    }

    notifyListeners();
    print("orderLength ${yourOrderList.length}");
  }
}
