import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return InkWell(
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(10),
        //   child: GridTile(
        //     child: Image.asset(
        //       'assets/images/product-placeholder.png',
        //       fit: BoxFit.cover,
        //     ),
        //     header: Text(''),
        //     footer: GridTileBar(
        //       backgroundColor: Colors.black87,
        //       title: Text(
        //         'product.title',
        //         textAlign: TextAlign.center,
        //         overflow: TextOverflow.fade,
        //       ),
        //       leading: Icon(Icons.favorite_border),
        //       trailing: IconButton(
        //         icon: Icon(Icons.add_shopping_cart),
        //         onPressed: () {},
        //       ),
        //     ),
        //   ),
        // ),
        );
  }
}
