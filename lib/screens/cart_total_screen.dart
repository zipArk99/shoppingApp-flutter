import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/models/your_orders.dart';
import 'package:shop/widgets/cart_item_widget.dart';

class CartTotalScreen extends StatelessWidget {
  static const CartTotalScreenRoute = "/CartTotalScreenRoute";

  @override
  Widget build(BuildContext contx) {
    var cart = Provider.of<Cart>(contx);
    var yourOrder = Provider.of<YourOrderList>(contx, listen: false);
    var cartItem = cart.item;
    var double = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(fontSize: 17),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      "\u20B9 ${cart.total}",
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(contx).primaryColor,
                  ),
                  TextButton(
                    onPressed: cart.item.length == 0
                        ? null
                        : () {
                            if (!cart.checkEmpty) {
                              yourOrder
                                  .addYourOrder(
                                cart.total,
                                cart.item.values.toList(),
                              )
                                  .then((value) {
                                cart.emptyCart();
                              });
                            } else {
                              print("Empty Cart");
                            }
                          },
                    child: Text("Order Now"),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (contx, index) {
                return CartItemWidget(
                    id: cart.item.values.toList()[index].cartItemId,
                    productId: cart.item.keys.toList()[index],
                    title: cart.item.values.toList()[index].title,
                    price: cart.item.values.toList()[index].price,
                    quantity: cart.item.values.toList()[index].quantity);
              },
              itemCount: cart.item.length,
            ),
          ),
        ],
      ),
    );
  }
}
