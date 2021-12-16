import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/your_orders.dart';
import 'package:shop/screens/drawer._screen.dart';
import 'package:shop/widgets/your_order_items.dart';

class YourOrderScreen extends StatefulWidget {
  static const yourOrderScreenRoute = "/YourOrderScreenRoute";

  @override
  _YourOrderScreenState createState() => _YourOrderScreenState();
}

class _YourOrderScreenState extends State<YourOrderScreen> {
  @override
  Widget build(BuildContext contx) {
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<YourOrderList>(contx, listen: false).fetchYourOrders(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.error != null) {
            print("SnapShot Error Caught");
          } else {
            return Consumer<YourOrderList>(
              builder: (contx, yourOrder, child) {
                return ListView.builder(
                  itemBuilder: (contx, index) {
                    return YourOrdersItem(
                      order: yourOrder.yourOrderList[index],
                    );
                  },
                  itemCount: yourOrder.yourOrderList.length,
                );
              },
            );
          }

          throw 1;
        },
      ),
    );
  }
}
