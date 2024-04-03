import 'dart:convert';

class Address{
  String name;
  String phone;
  String street;
  List ward;
  List district;
  List province;
  String id;

  Address(this.name, this.phone, this.street, this.ward, this.district, this.province, this.id);

  Address.fromJson(Map<String, dynamic> json):
    name = json["name"] ?? "",
    phone = json["phone"] ?? "",
    street = json['street'] ?? "",
    ward = json["ward"] != null ? List.from(json["ward"]) : [],
    district = json["district"] != null ? List.from(json["district"]) : [],
    province = json["province"] != null ? List.from(json["province"]) : [],
    id = json["_id"] ?? "";


  Map<String , dynamic> toJson(){
    return {
      'name' : name,
      'phone' : phone,
      'street' : street,
      'ward': jsonEncode(ward),
      'district' : jsonEncode(district),
      'province' : jsonEncode(province)
    };
  }
}