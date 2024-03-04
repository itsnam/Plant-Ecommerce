import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';

class CustomCard extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;

  const CustomCard({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isLoggedIn = false;
  String? email;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

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
    final response = await get(
      Uri.parse('$apiFavorites/$email'),
    );

    if (response.statusCode == 200) {
      List<dynamic> favoriteList = json.decode(response.body);

      if (mounted) {
        setState(() {
          isFavorite = favoriteList
              .any((favorite) => favorite['plantId']['_id'] == widget.id);
        });
      }
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
                child: const Text('OK'),
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
      body: json.encode({'userEmail': email, 'plantId': id}),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã loại sản phẩm ra khỏi mục yêu thích '),
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

  void addOrder(String email, String id, int quantity) async {
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

    final response = await post(
      Uri.parse(apiOrders),
      headers: {'Content-Type': 'application/json'},
      body:
          json.encode({'email': email, 'productId': id, 'quantity': quantity}),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sản phẩm đã được thêm vào giỏ hàng.'),
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

  @override
  Widget build(BuildContext context) {
    const itemWidth = 300.0;
    final f = NumberFormat.currency(locale: "vi_VN");
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailLayout(productId: widget.id),
          ),
        );
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
          child: Card(
            color: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            surfaceTintColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      // Image border
                      child: SizedBox(
                        height: itemWidth,
                        width: itemWidth * 0.85,
                        child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withAlpha(0),
                              Colors.black12,
                              Colors.black12,
                              Colors.black45
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: SizedBox(
                          height: 35,
                          width: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor:
                                    isFavorite ? favourite : Colors.white),
                            onPressed: () {
                              setState(() {
                                isFavorite = !isFavorite;
                              });
                              addToFavorites(email!, widget.id);
                            },
                            child: Icon(
                              Iconsax.heart5,
                              color: isFavorite
                                  ? Colors.white
                                  : unselectedMenuItem,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 7, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color(0xFFf9f9f9),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    f.format(widget.price),
                                    style: const TextStyle(
                                        color: Color(0xFFf9f9f9),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 20),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
