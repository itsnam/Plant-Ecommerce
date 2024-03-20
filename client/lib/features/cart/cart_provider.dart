import 'dart:convert';
import 'dart:core';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:plantial/features/cart/cart_item.dart';
import '../Url/url.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> cartItems = [];
  CartProvider(this.cartItems);
  List<CartItem> get items => cartItems;
  int get length => cartItems.length;

  int getTotalPrice(){
    int total = 0;
    for (CartItem cartItem in cartItems){
      total += cartItem.quantity * cartItem.product.price;
    }
    return total;
  }

  void updateOrder(String email) async {
    final response = await put(
      Uri.parse(apiOrders),
      headers: {'Content-Type': 'application/json'},
      body:
      json.encode({'email': email, 'cartItems': cartItems}),
    );
  }

  CartProvider.fromJson(Map<String, dynamic> json) {
    if (json['plants'] != null) {
      json['plants'].forEach((v){
        addToCart(CartItem.fromJson(v));
      });
    }
  }

  void increaseQuantity(String productId) {
    for (CartItem cartItem in cartItems) {
      if (cartItem.product.id == productId  && cartItem.quantity < 99) {
        cartItem.quantity += 1;
      }
    }
    notifyListeners();
  }

  void removeCartItem(String productId){
    cartItems.removeWhere((element) => element.product.id == productId);
    notifyListeners();
  }

  void decreaseQuantity(String productId) {
    for (CartItem cartItem in cartItems) {
      if (cartItem.product.id == productId && cartItem.quantity > 1) {
        cartItem.quantity -= 1;
      }
    }
    notifyListeners();
  }

  void addToCart(CartItem cartItem) {
    CartItem? existingCartItem = cartItems
        .firstWhereOrNull((i) => i.product.id == cartItem.product.id);
    if (existingCartItem != null) {
      existingCartItem.quantity += cartItem.quantity;
    } else {
      cartItems.add(cartItem);
    }
    notifyListeners();
  }

  int getShippingCharge() {
    if(length > 0){
      return 30000;
    }else{
      return 0;
    }
  }
}
