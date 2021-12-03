import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/screens/drawer._screen.dart';
import 'package:shop/widgets/badeg.dart';
import 'package:shop/widgets/products_gridview.dart';

enum Filter { favorite, all }

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _onlyFavorite = false;

  Widget build(BuildContext contx) {
    var cart = Provider.of<Cart>(
      contx,
      listen: false,
    );
    return Scaffold(
        drawer: DrawerScreen(),
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              onSelected: (Filter filt) {
                if (filt == Filter.favorite) {
                  setState(() {
                    _onlyFavorite = true;
                  });
                } else {
                  setState(() {
                    _onlyFavorite = false;
                  });
                }
              },
              icon: Icon(Icons.more_vert),
              itemBuilder: (contx) {
                return [
                  PopupMenuItem(
                    child: Text("Favorite"),
                    value: Filter.favorite,
                  ),
                  PopupMenuItem(
                    child: Text("All"),
                    value: Filter.all,
                  ),
                ];
              },
            ),
            Consumer<Cart>(
                builder: (contx, cart, ch) => Badge(
                      cartIcon: ch as Widget,
                      counter: cart.itemCounter,
                    ),
                child: Icon(Icons.add_shopping_cart))
          ],
          title: Text("Apni Dukan"),
        ),
        body: ProductsGridView(_onlyFavorite));
  }
}
