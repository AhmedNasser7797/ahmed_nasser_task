import 'package:fiction_task/provider/product_provider.dart';
import 'package:fiction_task/provider/products_provider.dart';
import 'package:fiction_task/ui/screens/user_info_screen.dart';
import 'package:fiction_task/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductsProvider>(
          create: (_) => ProductsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Fiction Apps Task',
        theme: AppTheme().lightTheme,
        debugShowCheckedModeBanner: false,
        home: UserInfoScreen(),
      ),
    );
  }
}
