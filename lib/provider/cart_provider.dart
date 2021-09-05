import 'package:fiction_task/model/cart_model.dart';
import 'package:flutter/cupertino.dart';

export 'package:provider/provider.dart';

class CartProvider with ChangeNotifier {
  CartModel cart;
  CartProvider(this.cart);
}
