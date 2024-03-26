import 'package:flutter/material.dart';
class PaymentMethod{
  String name;
  Icon icon;
  PaymentMethod(this.name, this.icon);

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
    };
  }
}