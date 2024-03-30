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

import '../../models/product.dart';

class ProductDetailLayout extends StatefulWidget {
  final Product product;

  const ProductDetailLayout({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductDetailLayout> createState() => _ProductDetailLayoutState();
}

class _ProductDetailLayoutState extends State<ProductDetailLayout> {
  int _quantity = 1;
  bool isLoggedIn = false;
  String? email;
  bool isFavorite = false;
  dynamic data;

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
            .any((plant) => plant['_id']['_id'] == widget.product.id);
      });
    }
  }

  void addToFavorites(String email, String id) async {
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
    checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
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
                          padding: const EdgeInsets.all(0),
                          onPressed: () {
                            if (isLoggedIn) {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                            }
                            addToFavorites(email!, widget.product.id);
                          },
                          icon: Icon(
                            isFavorite ? Iconsax.heart5 : Iconsax.heart,
                            color: isFavorite ? favourite : Colors.black,
                            size: 28,
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
                  borderRadius: const BorderRadius.all(Radius.circular(7)),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(150),
                    child: Image.network(
                      '$imageUrl${widget.product.imgUrl}',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: ProductDetail(
                product: widget.product,
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: const Offset(0, 3),
                spreadRadius: 5,
                blurRadius: 7)
          ]),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: unselectedMenuItem,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_quantity > 1) _quantity--;
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(
                              '$_quantity',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: primary,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            onPressed: () {
                              setState(() {
                                if (_quantity < widget.product.quantity) _quantity++;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {
                    addToCart(widget.product.id, _quantity);
                  },
                  style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(primary),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    )),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 3,
                    ),
                    child: Row(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
