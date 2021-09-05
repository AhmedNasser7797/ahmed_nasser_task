import 'package:fiction_task/model/product_model.dart';
import 'package:flutter/cupertino.dart';

export 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier {
  ProductModel product;
  ProductProvider(this.product);
}
