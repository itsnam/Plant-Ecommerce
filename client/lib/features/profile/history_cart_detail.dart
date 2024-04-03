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
import 'package:plantial/features/payment/payment_method.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/address/address.dart' as ad;
import '../Url/url.dart';
import '../cart/cart_item.dart';

class HistoryCartDetail extends StatefulWidget {
  final String id;

  const HistoryCartDetail(
      {Key? key,
      required this.id})
      : super(key: key);

  @override
  State<HistoryCartDetail> createState() => _HistoryCartDetailState();
}

class _HistoryCartDetailState extends State<HistoryCartDetail> {
  List <CartItem> cartItems = [];
  ad.Address? address;
  pm.PaymentMethod? paymentMethod;
  int status = 0;
  bool isLoading = true;
  String? vndToUsd;
  String? email;
  int? total;

  @override
  void initState() {
    super.initState();
    fetchOrderDetails();
    setState(() {
      total = getTotalPrice();
    });
  }

  Future<void> fetchOrderDetails() async {
    setState(() {
      isLoading = true;
    });

    final response = await get(Uri.parse('$apiOrders/get/${widget.id}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> orderData = jsonDecode(response.body);
      final List<dynamic> plantsData = orderData['plants'];

      List<CartItem> fetchedCartItems = plantsData.map((plantData) {
        return CartItem.fromJson(plantData);
      }).toList();

      final Map<String, dynamic> addressData = orderData['address'];
      final ad.Address fetchedAddress = ad.Address.fromJson(addressData);
      final String paymentMethodString = orderData['paymentMethod'];
      final int fetchedStatus= orderData['status'];

      Icon paymentIcon;
      switch (paymentMethodString) {
        case 'Credit card':
          paymentIcon = const Icon(Icons.credit_card);
          break;
        case 'COD':
          paymentIcon = const Icon(Icons.payments);
          break;
        default:
          paymentIcon = const Icon(Icons.payments); // Hoặc icon mặc định khác nếu cần
      }

      final pm.PaymentMethod fetchedPaymentMethod = pm.PaymentMethod(
        paymentMethodString,
        paymentIcon,
      );
      setState(() {
        cartItems = fetchedCartItems;
        address = fetchedAddress;
        paymentMethod = fetchedPaymentMethod;
        total = orderData['total'];
        isLoading = false;
        status = fetchedStatus;
      });
    } else {
      throw Exception('Failed to load order');
    }
  }

  int getTotalPrice() {
    int p = 0;
    for (CartItem i in cartItems) { 
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
          title: const Text("Lịch sửa mua hàng",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        body: isLoading 
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  DecoratedSliver(
                    decoration: const BoxDecoration(color: Colors.white),
                    sliver: SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Danh sách sản phẩm",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              Row(
                                children: [
                                  Text(
                                    (status == 2)
                                        ? 'Đang duyệt'
                                        : (status == 3)
                                            ? 'Đã duyệt'
                                            : 'Hủy đơn',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: (status == 2)
                                          ? Colors.black
                                          : (status == 3)
                                              ? Colors.green
                                              : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    (status == 2)
                                        ? Icons.access_time
                                        : (status == 3)
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                    color: (status == 2)
                                        ? Colors.black
                                        : (status == 3)
                                            ? Colors.green
                                            : Colors.red,
                                  ),
                                ],
                              ),
                            ],
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
                                itemCount: cartItems.length,
                                itemBuilder: (context, index) {
                                  return CheckOutItemCard(
                                      cartItem: cartItems[index]);
                                }),
                          ),
                          const SizedBox(height: 15),
                          const Text(
                            "Địa chỉ giao hàng",
                            style: (TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(height: 10),
                          CheckOutAddressCard(address: address),
                          const SizedBox(height: 15),
                          const Text(
                            "Phương thức thanh toán",
                            style: (TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                          const SizedBox(height: 10),
                          CheckOutPaymentCard(paymentMethod: paymentMethod ?? pm.PaymentMethod("Unknown", const Icon(Icons.payments))),
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
              bottomNavigationBar: isLoading // Kiểm tra nếu isLoading là true
                ? const SizedBox() // Nếu isLoading là true, không hiển thị bottomNavigationBar
                : Container(
                    // Nếu isLoading là false, hiển thị bottomNavigationBar bình thường
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
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      const MaterialStatePropertyAll(primary),
                                  shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7)))),
                              child: const Text(
                                "Quay về",
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
