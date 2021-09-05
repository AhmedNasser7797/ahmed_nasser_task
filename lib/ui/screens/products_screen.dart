import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:fiction_task/ui/screens/add_product_screen.dart';
import 'package:fiction_task/ui/screens/cart_screen.dart';
import 'package:fiction_task/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

import 'favorites_screen.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  AppBar _appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);
    final productsProvider = context.watch<ProductsProvider>();

    void showSnackBar(String title) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(title),
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          DragTarget(
            hitTestBehavior: HitTestBehavior.opaque,
            onAccept: (v) {
              productsProvider.addToCart(v);
              print('add to cart');
            },
            onLeave: (v) {
              return;
            },
            onWillAccept: (v) {
              productsProvider.addToCart(v);
              print('add to cart');
              return false;
            },
            builder: (BuildContext context, candidateData, rejectedData) =>
                IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              ),
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).appBarTheme.iconTheme.color,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: size.size.height -
            (_appbar.preferredSize.height + size.padding.top),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: productsProvider.products.length,
                      itemBuilder: (context, int i) =>
                          ChangeNotifierProvider<ProductProvider>(
                              create: (_) =>
                                  ProductProvider(productsProvider.products[i]),
                              child: ProductCard()),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6,
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8),
                    ),
                  )
                ],
              ),
            ),
            DragTarget(
              hitTestBehavior: HitTestBehavior.opaque,
              onAccept: (v) {
                productsProvider.addToFavorite(v);
                print('add to favorite');
              },
              onLeave: (v) {
                return;
              },
              onWillAccept: (v) {
                productsProvider.addToFavorite(v);
                print('add to favorite');
                return false;
              },
              builder: (BuildContext context, candidateData, rejectedData) =>
                  InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritesScreen(),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => AddProductScreen(),
          ),
        ),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}
