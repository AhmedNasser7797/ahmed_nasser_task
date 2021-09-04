import 'package:fiction_task/ui/screens/add_product_screen.dart';
import 'package:fiction_task/ui/screens/cart_screen.dart';
import 'package:fiction_task/ui/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  AppBar _appbar = AppBar();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Products',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
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
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.size.height -
              (_appbar.preferredSize.height + size.padding.top),
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
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 5,
                  itemBuilder: (context, int i) => ProductCard(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.7,
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                ),
              )
            ],
          ),
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
