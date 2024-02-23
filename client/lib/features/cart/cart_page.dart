import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantial/features/home/custom_card_2.dart';
import 'package:plantial/features/checkout/checkout_page_1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Url/url.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool isLoggedIn = false;
  String? email;
  bool isLoading = true;

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
      print(data["plants"][0]);
      return data["plants"];
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
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
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    const SliverAppBar(
                      backgroundColor: Color(0xFFf5f5f5),
                      leading: Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: BackButton(),
                      ),
                      centerTitle: true,
                      title: Text("My Cart",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20)),
                      pinned: false,
                      floating: true,
                      snap: false,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      sliver: SliverList.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCard2(
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
                    const SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Item Total"),
                                  Text("đ236.000")
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Shipping Charge"),
                                  Text("đ20.000")
                                ],
                              ),
                              SizedBox(height: 20),
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "đ256.000",
                                style: TextStyle(
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
                                      const MaterialStatePropertyAll(
                                          Color(0xFF4b8e4b)),
                                  shape: MaterialStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(7)))),
                              child: const Text(
                                "Mua hàng",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
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
