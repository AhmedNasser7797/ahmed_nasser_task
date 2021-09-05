import 'package:fiction_task/provider/cart_provider.dart';
import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:fiction_task/ui/widgets/cart_card.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart Screen',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        automaticallyImplyLeading: true,
      ),
      body: productsProvider.cart.isEmpty
          ? Center(
              child: Text('no product added in cart yet!'),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: productsProvider.cart.length,
              itemBuilder: (context, int i) =>
                  ChangeNotifierProvider<CartProvider>(
                create: (_) => CartProvider(productsProvider.cart[i]),
                child: CartCard(),
              ),
            ),
    );
  }
}
