import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/products_model.dart';
import 'package:shop/models/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const ProdcutDetailScreenRoute = "/Product-Detail-Screen";

  @override
  Widget build(BuildContext contx) {
    Map<String, String> routeArguments =
        ModalRoute.of(contx)!.settings.arguments as Map<String, String>;
    String productId = routeArguments['id'] as String;
    String image = routeArguments['image'] as String;

    Product productItem = Provider.of<ProductsProvider>(contx, listen: false)
        .getSingleProduct(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productItem.title),
      ),
      body: Center(
        child: Column(
          children: [Image.network(image)],
        ),
      ),
    );
  }
}
