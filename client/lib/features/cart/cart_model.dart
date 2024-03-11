import 'package:flutter/foundation.dart';
import 'package:plantial/features/cart/product_model.dart';
class CartModel extends ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items => _items;
  int get length => _items.length;

  void add(String productId) {
    for(Product p in _items){
      if(p.id == productId){
        p.quantity += 1;
      }
    }
    notifyListeners();
  }

  void minus(String productId) {
    for(Product p in _items){
      if(p.id == productId && p.quantity > 1){
        p.quantity -= 1;
      }
    }
    notifyListeners();
  }
}
