import 'package:flutter/material.dart';
import 'package:shop/main.dart';
import 'package:shop/screens/user_screen.dart';
import 'package:shop/screens/your_orders_screen.dart';

class DrawerScreen extends StatelessWidget {
  Widget build(BuildContext contx) {
    return Drawer(
      elevation: 10,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            alignment: Alignment.bottomLeft,
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(color: Theme.of(contx).primaryColor),
            child: Text(
              "Apna Choice",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(contx).pushReplacementNamed("/");
            },
            leading: Icon(
              Icons.shop,
              size: 30,
            ),
            title: const Text(
              "Shop",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(contx)
                  .pushReplacementNamed(YourOrderScreen.yourOrderScreenRoute);
            },
            leading: Icon(
              Icons.list_alt,
              size: 30,
            ),
            title: const Text(
              "Your Orders",
              style: TextStyle(fontSize: 17),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(contx)
                  .pushReplacementNamed(UserScreen.userScreenRoute);
            },
            leading: Icon(
              Icons.supervised_user_circle,
              size: 30,
            ),
            title: const Text(
              "User",
              style: TextStyle(fontSize: 17),
            ),
          )
        ],
      ),
    );
  }
}
