import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/models/products_model.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final double price;
  final int quantity;
  int total = 0;

  CartItemWidget(
      {required this.id,
      required this.productId,
      required this.title,
      required this.price,
      required this.quantity});
  @override
  Widget build(BuildContext contx) {
    var cart = Provider.of<Cart>(contx, listen: true);

    return Container(
      margin: EdgeInsets.all(5),
      child: Dismissible(
        confirmDismiss: (direction) {
          return showDialog(
              context: contx,
              builder: (contx) {
                return AlertDialog(
                  title: Text("Alert"),
                  content: Text("Do you really want to delete the item"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(contx).pop(false);
                      },
                      child: Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        cart.removeItem(productId);
                        Navigator.of(contx).pop(true);
                      },
                      child: Text(
                        "Confirm",
                      ),
                    ),
                  ],
                );
              });

          /*       cart.removeItem(productId); */
        },
        key: ValueKey(id),
        background: Container(
          color: Theme.of(contx).errorColor,
          margin: EdgeInsets.all(5),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 30,
          ),
        ),
        direction: DismissDirection.endToStart,
        child: Card(
          elevation: 5,
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(
                  child: Text(
                    "\$${price}",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              backgroundColor: Theme.of(contx).primaryColor,
              radius: 25,
            ),
            title: Text(title),
            subtitle: Text("Total:\$${price * quantity}"),
            trailing: Text("${quantity}X"),
          ),
        ),
      ),
    );
  }
}
