import 'package:flutter/foundation.dart';
import 'package:shop/models/cartitem_model.dart' as CI;

class YourOrder {
  final String orderId;
  final double totalPrice;
  final List<CI.CartItem> order;
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

  void addYourOrder(String orderId, double totalPrice, List<CI.CartItem> order,
      DateTime orderTime) {
    _yourOrderList.add(YourOrder(
        orderId: orderId,
        totalPrice: totalPrice,
        order: order,
        orderTime: orderTime));
    notifyListeners();
    print("orderLength ${yourOrderList.length}");
  }
}
