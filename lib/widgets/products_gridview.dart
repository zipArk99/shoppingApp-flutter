import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cartitem_model.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/widgets/products_provider.dart';
import 'package:shop/widgets/products_widget.dart';

class ProductsGridView extends StatelessWidget {
  final bool onlyFavorite;
  ProductsGridView(this.onlyFavorite);
  Widget build(BuildContext contx) {
    var productsProvider = Provider.of<ProductsProvider>(contx);

    List<Product> productsList = onlyFavorite
        ? productsProvider.onlyIsFavoriteFun
        : productsProvider.productList;

    return GridView.builder(
      padding: EdgeInsets.all(5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (contx, index) {
        return ChangeNotifierProvider.value(
          value: productsList[index],
          child: ProductsWidget(),
        );
      },
      itemCount: productsList.length,
    );
  }
}
