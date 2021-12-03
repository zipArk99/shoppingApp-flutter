import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/models/your_orders.dart';
import 'package:shop/screens/cart_total_screen.dart';
import 'package:shop/screens/product_detail_screen.dart';
import 'package:shop/screens/user_screen.dart';
import 'package:shop/screens/your_orders_screen.dart';
import 'package:shop/widgets/badeg.dart';
import 'package:shop/widgets/products_provider.dart';
import 'screens/product_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const myAppRoute = "/MyAppRoute";
  Widget build(BuildContext contx) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (contx) => ProductsProvider()),
        ChangeNotifierProvider(create: (contx) => Cart()),
        ChangeNotifierProvider(create: (contx) => YourOrderList()),
      ],
      child: MaterialApp(
        title: "ApnaDukan",
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.amber,
          fontFamily: 'Lato',
        ),
        home: HomePage(),
        routes: {
          myAppRoute: (contx) => MyApp(),
          ProductDetailScreen.ProdcutDetailScreenRoute: (contx) =>
              ProductDetailScreen(),
          CartTotalScreen.CartTotalScreenRoute: (contx) => CartTotalScreen(),
          YourOrderScreen.yourOrderScreenRoute: (contx) => YourOrderScreen(),
          UserScreen.userScreenRoute: (contx) => UserScreen(),
        },
      ),
    );
  }
}
