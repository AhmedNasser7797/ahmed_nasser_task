import 'package:fiction_task/provider/cart_provider.dart';
import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartCard extends StatefulWidget {
  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  Widget build(BuildContext context) {
    final product = context.watch<CartProvider>().cart;
    final productsProvider = context.watch<ProductsProvider>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  '${product.product.price}',
                  style: TextStyle(),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () {
                      if (mounted)
                        setState(() {
                          product.cartCount++;
                        });
                    },
                    child: Icon(Icons.add)),
                SizedBox(
                  width: 24,
                ),
                Text('${product.cartCount}'),
                SizedBox(
                  width: 24,
                ),
                InkWell(
                  onTap: () {
                    if (mounted)
                      setState(() {
                        if (product.cartCount == 0)
                          return productsProvider.removeFromCart(product);
                        product.cartCount--;
                      });
                  },
                  child: Text(
                    '-',
                    style: TextStyle(
                      fontSize: 38,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          width: 8,
        ),
        Image.asset(
          product.product.imageUrl,
          fit: BoxFit.fill,
          height: 100,
          width: 150,
        ),
      ],
    );
  }
}
