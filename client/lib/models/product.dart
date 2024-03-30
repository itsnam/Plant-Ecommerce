class Product {
  String id;
  String name;
  String type;
  int price;
  String imgUrl;
  int quantity;
  String description;
  int sold;

  Product({
    required this.description,
    required this.quantity,
    required this.id,
    required this.name,
    required this.type,
    required this.sold,
    required this.price,
    required this.imgUrl});

  Product.fromJson(Map<String, dynamic> json)
      : id = json["_id"],
        sold = json['sold'],
        name = json['name'],
        type = json['type'],
        price = json['price'],
        imgUrl = json['image'],
        description = json['description'],
        quantity = json['quantity'];

  Map toJson() => {
        '_id': id,
      };
}
