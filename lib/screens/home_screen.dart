import 'package:flutter/material.dart';
import 'package:products_app/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';

import '../models/models.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductService>(context);

    if (productService.isLoading) {
      return const LoadingScreen();
    }

    if (productService.isError) {
      return const ErrorScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final authService =
                  Provider.of<AuthService>(context, listen: false);
              authService.logout();
              Navigator.of(context).pushReplacementNamed('login');
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: productService.products.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  productService.productSelected =
                      productService.products[index].copy();
                  Navigator.pushNamed(context, 'product');
                },
                child: ProductCard(product: productService.products[index]),
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          productService.productSelected =
              Product(available: true, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
