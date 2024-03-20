class Address{
  String name;
  String phone;
  String street;
  List ward;
  List district;
  List province;

  Address(this.name, this.phone, this.street, this.ward, this.district, this.province);

  Address.fromJson(Map<String, dynamic> json):
    name = json["name"],
    phone = json["phone"],
    street = json['street'],
    ward = json["ward"],
    district = json["district"],
    province = json["province"];
}