import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';
import 'package:intl/intl.dart';

class CustomCard3 extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;
  final Function()? onFavoriteRemoved;
  final bool showFavoriteIcon;

  const CustomCard3({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
    this.onFavoriteRemoved,
    this.showFavoriteIcon = true,
  }) : super(key: key);

  @override
  State<CustomCard3> createState() => _CustomCard3State();
}

class _CustomCard3State extends State<CustomCard3> {
  bool isLoggedIn = false;
  String? email;
  bool isFavorite = false;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
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
    final response = await get(Uri.parse('$apiFavorites/$email'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> favoriteList = data['plants'];
      if (!_isDisposed) {
        setState(() {
          isFavorite = favoriteList.any((plant) => plant['_id']['_id'] == widget.id);
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
      if (widget.onFavoriteRemoved != null) {
        widget.onFavoriteRemoved!();
      }
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
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.transparent,
        surfaceTintColor: Colors.white,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: [
            Stack(children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(90),
                  child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                ),
              ),
              if (widget.showFavoriteIcon)
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
                      if (isLoggedIn) {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      }
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
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 35,
                    width: 35,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: primary),
                        onPressed: () {
                          addOrder(email!, widget.id, 1);
                        },
                        child: const Icon(
                          Iconsax.add,
                          color: Colors.white,
                          size: 20,
                        )),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                  Row(
                    children: [
                      Text(
                        f.format(widget.price),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
