import 'package:flutter/material.dart';
import 'package:shop/models/your_orders.dart';
import 'package:intl/intl.dart';

class YourOrdersItem extends StatefulWidget {
  final YourOrder order;

  YourOrdersItem({required this.order});

  @override
  _YourOrdersItemState createState() => _YourOrdersItemState();
}

class _YourOrdersItemState extends State<YourOrdersItem> {
  var _expanded = false;

  Widget build(BuildContext contx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        child: Column(
          children: [
            ListTile(
              title: Text("${widget.order.totalPrice}"),
              subtitle: Text(DateFormat.MMMEd().format(widget.order.orderTime)),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  Icons.expand_more,
                  size: 25,
                ),
              ),
            ),
            if (_expanded)
              Container(
                  child: Column(
                children: [
                  ...widget.order.order.map((element) {
                    return ListTile(
                      leading: Text(element.title),
                      trailing: Text("\$${element.price}"),
                    );
                  }),
                ],
              )),
          ],
        ),
      ),
    );
  }
}
