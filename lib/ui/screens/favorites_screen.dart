import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:fiction_task/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = context.watch<ProductsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorites Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        itemCount: productsProvider.favorites.length,
        itemBuilder: (context, int i) =>
            ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(productsProvider.favorites[i]),
          child: ProductCard(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.7,
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8),
      ),
    );
  }
}
