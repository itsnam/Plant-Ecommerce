import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';

class CustomCard1 extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;
  final Function()? onFavoriteRemoved; 

  const CustomCard1({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
    this.onFavoriteRemoved,
  }) : super(key: key);

  @override
  State<CustomCard1> createState() => _CustomCard1State();
}

class _CustomCard1State extends State<CustomCard1> {
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
          isFavorite = favoriteList.any((favorite) => favorite['plantId']['_id'] == widget.id);
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
            content: const Text('Vui lòng đăng nhập để thêm sản phẩm vào mục yêu thích.'),
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
      headers: {
        'Content-Type': 'application/json'
      },
      body: json.encode({
        'userEmail': email,
        'plantId': id
      }), 
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã loại sản phẩm ra khỏi mục yêu thích '),
          duration: Duration(seconds: 1),
        ),
      );
      if (widget.onFavoriteRemoved != null) {
        widget.onFavoriteRemoved!();
      }
    }else if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã thêm vào mục yêu thích'),
          duration: Duration(seconds: 1),
        ),
      );
    }else {
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailLayout(productId: widget.id),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Card(
          shadowColor: Colors.transparent,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(7), bottomLeft: Radius.circular(7)),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(60),
                  child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 20),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              'đ${widget.price}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 16),
                            ),
                          ),
                          Row(children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: const Color(0xFFDDDDDD)),
                                  onPressed: () {
                                    setState(() {
                                      isFavorite = !isFavorite; 
                                    });
                                    addToFavorites(email!, widget.id);
                                  },
                                  child: Icon(
                                    Iconsax.heart5,
                                    color: isFavorite ? const Color(0xFF4b8e4b) : Colors.white,
                                    size: 20,
                                  )),
                            ),
                            const SizedBox(width: 7.0),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      backgroundColor: const Color(0xFF4b8e4b)),
                                  onPressed: null,
                                  child: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            ),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
