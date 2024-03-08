import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/cart/cart_item.dart';
import 'package:plantial/features/checkout/checkout_page_1.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Url/url.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoggedIn = false;
  String? email;

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
  }

  Future<List<dynamic>> fetchData() async {
    final response = await get(Uri.parse('$apiOrders/$email'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data["plants"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  int calculateItemTotal(List<dynamic> data) {
    int total = 0;
    for (int i = 0; i < data.length; i++) {
      int price = data[i]['_id']['price'];
      int quantity = data[i]['quantity'];
      total += (price * quantity).round();
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(locale: "vi_VN");
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),
              ));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              List<dynamic> data = snapshot.data!;
              int itemTotal = calculateItemTotal(data);
              int shippingCharge = 30000;
              int total = itemTotal + shippingCharge;
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      toolbarHeight: 70,
                      backgroundColor: background,
                      leading: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: CustomBackButton(
                          color: Colors.black,
                        ),
                      ),
                      centerTitle: true,
                      title: Text("Giỏ hàng",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                      pinned: true,
                      floating: true,
                      snap: false,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      sliver: SliverList.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCard2(
                            updateQuantity: () {
                              setState(() {

                              });
                            },
                            id: data[index]['_id']["_id"],
                            name: data[index]['_id']['name'],
                            type: data[index]['_id']['type'],
                            price: data[index]['_id']['price'],
                            imgUrl:
                                'http://10.0.2.2:3000/${data[index]['_id']['image']}',
                            quantity: data[index]['quantity'],
                          );
                        },
                      ),
                    ),

                    SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Item Total",
                                      style: TextStyle(
                                          height: 0,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  Text(
                                      f.format(
                                        itemTotal,
                                      ),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          height: 0,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Shipping Charge",
                                    style: TextStyle(
                                        fontSize: 14,
                                        height: 0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    f.format(shippingCharge),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        height: 0,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        )),
                  ],
                ),
                bottomNavigationBar: Container(
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tổng cộng",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                f.format(total),
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 55,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CheckOutPage1()));
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(primary),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  )),
                              child: const Text(
                                "Mua hàng",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
