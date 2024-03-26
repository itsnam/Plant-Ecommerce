import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/payment/payment_card.dart';
import 'package:plantial/features/checkout/checkout_page.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/payment/payment_method.dart';
import 'package:plantial/features/styles/styles.dart';

import '../address/address.dart';
import '../cart/cart_item.dart';

class PaymentPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final Address? address;

  const PaymentPage({
    super.key,
    required this.cartItems,
    required this.address,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final List<PaymentMethod> paymentMethods = [
    PaymentMethod("Credit card", const Icon(Icons.credit_card)),
    PaymentMethod("COD", const Icon(Icons.payments)),
  ];
  late PaymentMethod selectedMethod = paymentMethods[0];

  onChangeAddress(value) {
    setState(() {
      selectedMethod = value;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text("Phương thức thanh toán",
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
                      "Phương thức thanh toán",
                      style: (TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: paymentMethods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PaymentCard(
                          paymentMethod: paymentMethods[index],
                          onChanged: onChangeAddress,
                          selectedPaymentMethod: selectedMethod,
                        );
                      },
                    ),
                  ]),
                ),
              ),
            ),
            const DecoratedSliver(
              decoration: BoxDecoration(color: Colors.white),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(),
              ),
            )
          ],
        ),
        bottomNavigationBar: Container(
          height: 85,
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
                SizedBox(
                  height: 55,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOutPage(
                                    paymentMethod: selectedMethod,
                                    cartItems: widget.cartItems,
                                    address: widget.address,
                                  )));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(primary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                    child: const Text(
                      "Xác nhận",
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
}
