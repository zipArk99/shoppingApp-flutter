import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/screens/cart_total_screen.dart';

class Badge extends StatelessWidget {
  final Widget cartIcon;
  final int counter;

  Badge({
    required this.cartIcon,
    required this.counter,
  });

  @override
  Widget build(BuildContext contx) {
    print("inside badge");
    var cart = Provider.of<Cart>(contx);
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          icon: cartIcon,
          onPressed: () {
            Navigator.of(contx).pushNamed(CartTotalScreen.CartTotalScreenRoute);
          },
        ),
        Positioned(
          bottom: 10,
          left: 6,
          child: Container(
            alignment: Alignment.center,
            height: 20,
            width: 19,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: Text(
              cart.item.length.toString(),
              style: TextStyle(
                fontSize: 9,
              ),
            ),
          ),
        )
      ],
    );
  }
}
