import 'dart:convert';

import 'package:currency_converter/currency.dart';
import 'package:currency_converter/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/checkout/address_card.dart';
import 'package:plantial/features/checkout/checkout_controller.dart';
import 'package:plantial/features/checkout/item_card.dart';
import 'package:plantial/features/checkout/payment_card.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/payment/payment_method.dart' as pm;
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/address/address.dart' as ad;
import '../Url/url.dart';
import '../cart/cart_item.dart';

class CheckOutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final ad.Address? address;
  final pm.PaymentMethod paymentMethod;

  const CheckOutPage(
      {Key? key,
      required this.cartItems,
      required this.address,
      required this.paymentMethod})
      : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  bool isLoading = false;
  String? vndToUsd;
  String? email;
  int? total;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    setState(() {
      total = getTotalPrice();
    });
  }

  int getTotalPrice() {
    int p = 0;
    for (CartItem i in widget.cartItems) {
      p += i.quantity * i.product.price;
    }
    return p;
  }

  Future<bool> makePayment(context) async {
    setState(() {
      isLoading = false;
    });
    return true;
  }

  Future<void> convert() async {
    var usdConvert = await CurrencyConverter.convert(
      from: Currency.vnd,
      to: Currency.usd,
      amount: getTotalPrice() + 30000,
      withoutRounding: false,
    );
    setState(() {
      vndToUsd = (usdConvert! * 100).toInt().toString();
    });
  }

  Future sendOrderRequest(String email, ad.Address? address, pm.PaymentMethod paymentMethod) async {
    var response = put(Uri.parse('$apiOrders/$email'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'address': address?.toJson(),
          'paymentMethod': paymentMethod.toJson(),
          'total': total! + 30000
        }));
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat.currency(locale: "vi_VN");
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          leading: const Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CustomBackButton(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          title: const Text("Đặt hàng",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        body: CustomScrollView(
          slivers: [
            DecoratedSliver(
              decoration: const BoxDecoration(color: Colors.white),
              sliver: SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const Text(
                      "Danh sách sản phẩm",
                      style: (TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: unselectedMenuItem,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.cartItems.length,
                          itemBuilder: (context, index) {
                            return CheckOutItemCard(
                                cartItem: widget.cartItems[index]);
                          }),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Địa chỉ giao hàng",
                      style: (TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),
                    CheckOutAddressCard(address: widget.address),
                    const SizedBox(height: 15),
                    const Text(
                      "Phương thức thanh toán",
                      style: (TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 10),
                    CheckOutPaymentCard(paymentMethod: widget.paymentMethod),
                    const SizedBox(height: 15),
                    const Text(
                      "Chi tiết thanh toán",
                      style: (TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                    const SizedBox(height: 5),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Tạm tính",
                                style: TextStyle(fontWeight: FontWeight.w400)),
                            Text(
                                f
                                    .format(getTotalPrice())
                                    .replaceFirst("VND", ""),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Phí giao hàng",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                            Text(f.format(30000).replaceFirst("VND", ""),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                      ],
                    )
                  ]),
                ),
              ),
            ),
            const DecoratedSliver(
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(),
                ),
                decoration: BoxDecoration(color: Colors.white))
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
                offset: const Offset(0, 0), // changes position of shadow
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
                      "Tổng thanh toán",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      f.format(total! + 30000),
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
                    onPressed: () async {
                      if (widget.paymentMethod.name != "COD") {
                        await convert()
                            .then((value) => CheckOutController()
                                .makePayment(context, vndToUsd!))
                            .then((value) => sendOrderRequest(
                                email!, widget.address, widget.paymentMethod));
                      } else {
                        sendOrderRequest(
                                email!, widget.address, widget.paymentMethod)
                            .then((value) => Navigator.of(context)
                                .popUntil((route) => route.isFirst));
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(primary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                    child: const Text(
                      "Đặt hàng",
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
}
