import 'dart:convert';

import 'package:plantial/features/address/address.dart';

class AddressList {
  List<Address> addressList = [];

  AddressList();

  List<Address> get items => addressList;

  int get length => addressList.length;

  AddressList.fromJson(Map<String, dynamic> json) {
    if (json['addresses'] != null) {
      json['addresses'].forEach((e){
        addressList.add(Address.fromJson(e));
      });
    }
  }
}
