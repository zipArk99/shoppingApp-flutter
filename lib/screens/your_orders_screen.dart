import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/your_orders.dart';
import 'package:shop/screens/drawer._screen.dart';
import 'package:shop/widgets/your_order_items.dart';

class YourOrderScreen extends StatelessWidget {
  static const yourOrderScreenRoute = "/YourOrderScreenRoute";

  Widget build(BuildContext contx) {
    var yourOrder = Provider.of<YourOrderList>(contx);
    print("xxxxxxxxxxxxxx::" + yourOrder.yourOrderList.length.toString());
    return Scaffold(
        drawer: DrawerScreen(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: ListView.builder(
          itemBuilder: (contx, index) {
            return YourOrdersItem(order: yourOrder.yourOrderList[index]);
          },
          itemCount: yourOrder.yourOrderList.length,
        ));
  }
}
