import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/cart/cart_provider.dart';
import 'package:plantial/features/cart/cart_item_card.dart';
import 'package:plantial/features/address/address_page.dart';
import 'package:plantial/features/commons/custom_back_button_with_function.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Url/url.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? email;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await get(Uri.parse('$apiOrders/$email'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
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
                valueColor: AlwaysStoppedAnimation(primary),
              ));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primary),
              ));
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Empty'),
              );
            } else {
              return ChangeNotifierProvider(
                create: (BuildContext context) =>
                    CartProvider.fromJson(snapshot.data!),
                child: Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        toolbarHeight: 70,
                        backgroundColor: background,
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Consumer<CartProvider>(
                            builder: (BuildContext context, CartProvider value, Widget? child) {  
                              return CustomBackButtonWithFunction(
                                color: Colors.black,
                                onPressed: () {
                                  value.updateOrder(email!);
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        ),
                        centerTitle: true,
                        title: const Text("Giỏ hàng",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20)),
                        pinned: true,
                        floating: true,
                        snap: false,
                      ),
                      Consumer<CartProvider>(
                        builder:
                            (BuildContext context, instance, Widget? child) {
                          return SliverPadding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            sliver: SliverList.builder(
                              itemCount: instance.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Stack(
                                    children: [
                                      Positioned.fill(
                                        child: Padding(
                                              padding: const EdgeInsets
                                                  .fromLTRB(15, 0, 15, 0),
                                              child: Container(
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                      ),
                                      Slidable(
                                        key: ValueKey(index),
                                        endActionPane: ActionPane(
                                          extentRatio: 0.25,
                                          motion: const StretchMotion(),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                instance.removeCartItem(instance.cartItems[index].product.id);
                                              } ,
                                              backgroundColor: Colors.redAccent,
                                              foregroundColor: Colors.white,
                                              icon: Iconsax.trash,
                                              borderRadius: const BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        child: CustomCard2(
                                          id: instance.items[index].product.id,
                                          name: instance
                                              .items[index].product.name,
                                          type: instance
                                              .items[index].product.type,
                                          price: instance
                                              .items[index].product.price,
                                          imgUrl: instance
                                              .items[index].product.imgUrl,
                                          quantity:
                                              instance.items[index].quantity,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        },
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
                                    const Text("Tạm tính",
                                        style: TextStyle(
                                            height: 0,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400)),
                                    Consumer<CartProvider>(
                                      builder: (BuildContext context,
                                          CartProvider value, Widget? child) {
                                        return Text(
                                            f
                                                .format(value.getTotalPrice())
                                                .replaceFirst("VND", ""),
                                            style: const TextStyle(
                                                fontSize: 14,
                                                height: 0,
                                                fontWeight: FontWeight.w400));
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Phí giao hàng",
                                      style: TextStyle(
                                          fontSize: 14,
                                          height: 0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Consumer<CartProvider>(
                                      builder: (BuildContext context, CartProvider value, Widget? child) {
                                        return Text(
                                          f
                                              .format(value.getShippingCharge())
                                              .replaceFirst("VND", ""),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              height: 0,
                                              fontWeight: FontWeight.w400),
                                        );
                                      },
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                              Consumer<CartProvider>(
                                builder: (BuildContext context,
                                    CartProvider value, Widget? child) {
                                  return Text(
                                    f.format(value.getTotalPrice() +
                                        value.getShippingCharge()),
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  );
                                },
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Consumer<CartProvider>(
                            builder: (BuildContext context, CartProvider value, Widget? child) {
                              return SizedBox(
                                height: 55,
                                child: TextButton(
                                  onPressed: () {
                                    value.updateOrder(email!);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            CheckOutPage1(email: email!, cartItems: value.items,)));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          primary),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7),
                                        ),
                                      )),
                                  child: const Text(
                                    "Xác nhận",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              );
                            },
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
