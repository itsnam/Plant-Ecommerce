import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/product_detail/product_detail.dart';
import 'package:http/http.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailLayout extends StatefulWidget {
  final String productId;

  const ProductDetailLayout({Key? key, required this.productId})
      : super(key: key);

  @override
  State<ProductDetailLayout> createState() => _ProductDetailLayoutState();
}

class _ProductDetailLayoutState extends State<ProductDetailLayout> {
  int _quantity = 1;
  bool isLoggedIn = false;
  String? email;
  bool isFavorite = false;

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      email = prefs.getString('email');
    });

    if (isLoggedIn) {
      checkIsFavorite();
    }
  }

  Future<void> checkIsFavorite() async {
    final response = await get(Uri.parse('$apiFavorites/$email'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> favoriteList = data['plants'];
      setState(() {
        isFavorite = favoriteList
            .any((plant) => plant['_id']['_id'] == widget.productId);
      });
    }
  }

  void addToFavorites(String email, String id) async {
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Yêu cầu đăng nhập'),
            content: const Text(
                'Vui lòng đăng nhập để thêm sản phẩm vào mục yêu thích.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Huỷ'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/auth");
                },
                child: const Text("Đăng nhập"),
              ),
            ],
          );
        },
      );
      return;
    }

    final response = await post(
      Uri.parse('$apiFavorites/add'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'productId': id}),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã loại sản phẩm ra khỏi mục yêu thích'),
          duration: Duration(seconds: 1),
        ),
      );
    } else if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã thêm vào mục yêu thích'),
          duration: Duration(seconds: 1),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: Text(response.body),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      _quantity = newQuantity;
    });
  }

  dynamic data;

  Future<void> fetchSingleData() async {
    final response = await get(Uri.parse('$apiPlants/${widget.productId}'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> addToCart(String productId, int quantity) async {
    if (!isLoggedIn) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Yêu cầu đăng nhập'),
            content:
                const Text('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    var body = {
      'email': email,
      'productId': productId,
      'quantity': quantity,
    };
    var jsonString = json.encode(body);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response =
        await post(Uri.parse(apiOrders), headers: headers, body: jsonString);
    if (response.statusCode == 200) {
      data = json.decode(response.body);
      if (!context.mounted) return;
      Navigator.pop(context);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSingleData();
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: data == null
            ? const Center(child: CircularProgressIndicator())
            : data.isEmpty
                ? const Center(child: Text('No data available'))
                : CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        pinned: false,
                        backgroundColor: Colors.white,
                        toolbarHeight: 70,
                        leading: const CustomBackButton(color: Colors.black),
                        actions: [
                          isLoggedIn
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 15),
                                  child: IconButton(
                                    onPressed: () {
                                      if (isLoggedIn) {
                                        setState(() {
                                          isFavorite = !isFavorite;
                                        });
                                      }
                                      addToFavorites(email!, widget.productId);
                                    },
                                    icon: Icon(
                                      isFavorite
                                          ? Iconsax.heart5
                                          : Iconsax.heart,
                                      color:
                                          isFavorite ? favourite : Colors.black,
                                      size: 24,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 30, top: 10),
                        sliver: SliverToBoxAdapter(
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(7)),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(150),
                              child: Image.network(
                                '$imageUrl${data['image']}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: ProductDetail(
                          name: data['name'],
                          description: data['description'],
                          sold: data['sold'],
                          quantity: data['quantity'],
                          price: data['price'],
                          onQuantityUpdated: updateQuantity,
                        ),
                      ),
                    ],
                  ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: TextButton(
              onPressed: () {
                addToCart(widget.productId, _quantity);
              },
              style: ButtonStyle(
                backgroundColor: const MaterialStatePropertyAll(primary),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.shopping_cart,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Thêm vào giỏ hàng",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
