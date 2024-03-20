class Product {
  String id;
  String name;
  String type;
  int price;
  String imgUrl;

  Product({required this.id, required this.name, required this.type, required this.price, required this.imgUrl});

  Product.fromJson(Map<String, dynamic> json) :
    id = json["_id"],
    name= json['name'],
    type=json['type'],
    price=json['price'],
    imgUrl=json['image'];

  Map toJson() => {
    '_id' : id,
  };
}
