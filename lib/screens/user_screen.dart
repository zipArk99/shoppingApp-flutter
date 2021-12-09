import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/screens/drawer._screen.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/models/products_provider.dart';
import 'package:shop/widgets/user_product_item.dart';

class UserScreen extends StatelessWidget {
  static const userScreenRoute = "/UserScreenRoute";
  @override
  Widget build(BuildContext contx) {
    ProductsProvider product = Provider.of<ProductsProvider>(contx);
    return Scaffold(
      drawer: DrawerScreen(),
      appBar: AppBar(
        title: Text("User"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(contx)
                  .pushNamed(EditProductScreen.EditProductScreenRoute);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (contx, index) {
          return Column(
            children: [
              UserProductItem(
                productTitle: product.productList[index].title,
                id: product.productList[index].id,
                imageUrl: product.productList[index].imageUrl,
                productPrice: product.productList[index].price,
              ),
              Divider(
                color: Colors.black45,
              )
            ],
          );
        },
        itemCount: product.productList.length,
      ),
    );
  }
}
