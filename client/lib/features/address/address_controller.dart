import 'package:flutter/material.dart';

class AddressController {
  List data = [];
  List provinces = [];
  List districts = [];
  List wards = [];

  String? provinceValue;
  String? districtValue;
  String? wardValue;

  List province = [];
  List district = [];
  List ward = [];

  List<DropdownMenuItem> getProvinceList() {
    return data.map((e) {
      return DropdownMenuItem(
        value: e[3].toString(),
        child: Text(
          "${e[2]} ${e[1]}",
          style: const TextStyle(fontWeight: FontWeight.w400),
        ),
      );
    }).toList();
  }

  List<DropdownMenuItem> getDistrictList() {
    if (provinceValue != null) {
      provinces = data.firstWhere((element) => element[3] == provinceValue);
      province = [provinces[1], provinces[2], provinces[3]];
      districts = provinces[4];
      return districts.map((e) {
        return DropdownMenuItem(
            value: e[3].toString(),
            child: Text("${e[2]} ${e[1]}",
                style: const TextStyle(fontWeight: FontWeight.w400)));
      }).toList();
    }
    return [];
  }

  List<DropdownMenuItem> getWardList() {
    if (districtValue != null) {
      List ward = districts.firstWhere((e) => e[3] == districtValue);
      district = [ward[1], ward[2], ward[3]];
      wards = ward[4];
      return wards.map((e) {
        return DropdownMenuItem(
            value: e[3].toString(),
            child: Text("${e[2]} ${e[1]}",
                style: const TextStyle(fontWeight: FontWeight.w400)
            )
        );
      }).toList();
    }
    return [];
  }

  void getWard() {
    if(wardValue != null){
      List result = wards.firstWhere((e) => e[3] == wardValue);
      ward = [result[1], result[2], result[3]];
    }
  }
}
