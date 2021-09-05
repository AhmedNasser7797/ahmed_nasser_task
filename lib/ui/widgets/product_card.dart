import 'package:fiction_task/model/product_model.dart';
import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int cartCount = 0;

  void favorite() {
    final product = context.read<ProductProvider>().product;

    final productsProvider = context.read<ProductsProvider>();
    productsProvider.setFavorite(product);
  }

  bool isAddedToCart() {
    final product = context.watch<ProductProvider>().product;

    final cart = context.watch<ProductsProvider>().cart;
    if (cart.isEmpty)
      return false;
    else
      for (int i = 0; i < cart.length; i++) {
        if (cart[i].product.id == product.id) {
          return true;
        }
      }
    return false;
  }

  Widget build(BuildContext context) {
    final product = context.watch<ProductProvider>().product;
    final productsProvider = context.watch<ProductsProvider>();

    return LongPressDraggable<ProductModel>(
      data: product,
      child: InkWell(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl != null)
                  Image.asset(
                    product.imageUrl,
                    fit: BoxFit.fill,
                    height: 120,
                    width: double.infinity,
                  )
                else
                  Image.file(
                    product.imageFile,
                    fit: BoxFit.fill,
                    height: 120,
                    width: double.infinity,
                  ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  product.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 8,
                ),
                if (product.priceForSale != null)
                  Row(
                    children: [
                      Text("Price"),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${product.priceForSale}",
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      if (product.priceForSale != null)
                        Text(
                          "${product.price}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.red),
                        ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Text("Price"),
                      SizedBox(
                        width: 8,
                      ),
                      Text("${product.price}"),
                    ],
                  ),
                SizedBox(
                  height: 8,
                ),
                if (isAddedToCart())
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                          onTap: () {
                            productsProvider.cart
                                .firstWhere((element) =>
                                    element.product.id == product.id)
                                .cartCount++;
                            if (mounted) setState(() {});
                          },
                          child: Icon(Icons.add)),
                      Text(
                          '${productsProvider.cart.firstWhere((element) => element.product.id == product.id).cartCount}'),
                      InkWell(
                        onTap: () {
                          if (productsProvider.cart
                                  .firstWhere((element) =>
                                      element.product.id == product.id)
                                  .cartCount ==
                              0)
                            return productsProvider.removeFromCart(
                                productsProvider.cart.firstWhere((element) =>
                                    element.product.id == product.id));
                          productsProvider.cart
                              .firstWhere(
                                  (element) => element.product.id == product.id)
                              .cartCount--;

                          if (mounted) setState(() {});
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
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
      feedback: Material(
        child: Column(
          children: [
            if (product.imageUrl != null)
              Image.asset(
                product.imageUrl,
                fit: BoxFit.fill,
                height: 120,
                width: MediaQuery.of(context).size.width * 0.35,
              )
            else
              Image.file(
                product.imageFile,
                fit: BoxFit.fill,
                height: 120,
                width: MediaQuery.of(context).size.width * 0.35,
              ),
            SizedBox(
              height: 8,
            ),
            Text(
              product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
