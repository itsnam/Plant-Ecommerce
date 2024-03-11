class Product {
  final String id;
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  late int quantity;

  Product({required this.id, required this.name, required this.type, required this.price, required String this.imgUrl, required this.quantity});

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      id: json['_id']["_id"],
      name: json['_id']['name'],
      type: json['_id']['type'],
      price: json['_id']['price'],
      imgUrl: 'http://10.0.2.2:3000/${json['_id']['image']}',
      quantity: json['quantity'],
    );
  }
}