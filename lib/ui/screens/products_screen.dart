import 'package:fiction_task/model/product_model.dart';
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

    Future<void> showSnackBar(String title) async {
      await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.grey,
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
            // onAccept: (v) {
            //   print(' onAccept');
            //   for (int i = 0; i < productsProvider.cart.length; i++) {
            //     if (productsProvider.cart[i].product.id == v.id)
            //       return showSnackBar('already added to cart!');
            //     else {
            //       productsProvider.addToCart(v);
            //       showSnackBar('added to cart!');
            //     }
            //     print('add to cart');
            //   }
            // },
            // onLeave:(v) {
            //   print('on leave');
            //   for (int i = 0; i < productsProvider.cart.length; i++) {
            //     if (productsProvider.cart[i].product.id == v.id) {
            //       showSnackBar('already added to cart!');
            //     } else {
            //       productsProvider.addToCart(v);
            //       showSnackBar('added to cart!');
            //     }
            //   }
            //   return false;
            //
            // },
            onWillAccept: (v) {
              print('on onWillAccept cart');

              for (int i = 0; i < productsProvider.cart.length; i++) {
                if (productsProvider.cart[i].product.id == v.id) {
                  showSnackBar('already added to cart!');
                  return false;
                }
              }
              productsProvider.addToCart(v);
              showSnackBar('added to cart!');

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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: size.size.height -
            (_appbar.preferredSize.height + size.padding.top),
        child: Row(
          children: [
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
            ),
            DragTarget(
              hitTestBehavior: HitTestBehavior.opaque,
              // onAccept: (ProductModel v) {
              //   if (v.isFavorite) {
              //     showSnackBar('already added to favorite');
              //   } else {
              //     productsProvider.addToCart(v);
              //     showSnackBar('added to favorite!');
              //   }
              //
              //   return false;
              // },
              // onLeave: (ProductModel v) {
              //   if (v.isFavorite) {
              //     showSnackBar('already added to favorite');
              //   } else {
              //     productsProvider.addToFavorite(v);
              //     showSnackBar('added to favorite!');
              //   }
              //
              //   return false;
              // },
              onWillAccept: (ProductModel v) {
                if (v.isFavorite) {
                  showSnackBar('already added to favorite');
                } else {
                  productsProvider.addToFavorite(v);
                  showSnackBar('added to favorite!');
                }

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
