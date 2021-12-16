import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop/models/cartitem_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/screens/product_detail_screen.dart';

class ProductsWidget extends StatelessWidget {
  void buildSnackBar(BuildContext contx, Function remove, String id) {
    ScaffoldMessenger.of(contx).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text("Item inserted into cart"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            remove(id);
          },
        ),
      ),
    );
  }

  Widget build(BuildContext contx) {
    print("==========ProductWidget Called========");
    var singleProduct = Provider.of<Product>(contx, listen: false);
    var cart = Provider.of<Cart>(contx);

    return InkWell(
      splashColor: Theme.of(contx).accentColor,
      onTap: () {
        Navigator.of(contx).pushNamed(
            ProductDetailScreen.ProdcutDetailScreenRoute,
            arguments: {
              'id': singleProduct.id,
              'image': singleProduct.imageUrl
            });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GridTile(
          child: Image.network(
            singleProduct.imageUrl,
            fit: BoxFit.contain,
          ),
          header: GridTileBar(
            backgroundColor: Colors.black54,
            title: Center(
              child: Text(singleProduct.title),
            ),
          ),
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (contx, product, child) => IconButton(
                color: Theme.of(contx).accentColor,
                icon: Icon(singleProduct.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border_sharp),
                onPressed: () {
                  singleProduct.setIsFavorite().catchError((error) {
                    ScaffoldMessenger.of(contx).showSnackBar(
                      SnackBar(
                        content: Text("Change Unsuccessful"),
                      ),
                    );
                  });
                },
              ),
            ),
            backgroundColor: Colors.black87,
            title: Center(
              child: Text("\$${singleProduct.price}"),
            ),
            trailing: cart.checkAvailability(singleProduct.id)
                ? IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Theme.of(contx).accentColor,
                    ),
                    onPressed: () {
                      cart.addItem(singleProduct.id, singleProduct.title,
                          singleProduct.price);
                      ScaffoldMessenger.of(contx).hideCurrentSnackBar();
                      buildSnackBar(
                          contx, cart.removeCartItem, singleProduct.id);
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: Theme.of(contx).accentColor,
                    ),
                    onPressed: () {
                      cart.addItem(singleProduct.id, singleProduct.title,
                          singleProduct.price);
                      ScaffoldMessenger.of(contx).hideCurrentSnackBar();
                      buildSnackBar(
                          contx, cart.removeCartItem, singleProduct.id);
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
/* ListTile(
                    leading: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                    title: Text("1"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.minimize,
                      ),
                    ),
                  ) */