import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int cartCount = 0;
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/images/product-placeholder.png',
                fit: BoxFit.fill,
                height: 120,
                width: double.infinity,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                'product name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text('product description'),
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
                            cartCount++;
                          });
                      },
                      child: Icon(Icons.add)),
                  Text('$cartCount'),
                  InkWell(
                    onTap: () {
                      if (mounted)
                        setState(() {
                          if (cartCount == 0) return;
                          cartCount--;
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
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
