import 'package:flutter/material.dart';
import 'package:plantial/features/checkout/address_card_2.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/checkout/item_card.dart';
import 'package:plantial/features/checkout/payment_card_2.dart';

class CheckOutPage3 extends StatefulWidget {
  const CheckOutPage3({Key? key}) : super(key: key);

  @override
  State<CheckOutPage3> createState() => _CheckOutPage3State();
}

class _CheckOutPage3State extends State<CheckOutPage3> {

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: BackButton(),
              ),
              centerTitle: true,
              title: Text("Checkout",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              pinned: false,
              floating: true,
              snap: false,
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(color: Colors.white),
              sliver: SliverPadding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFedf4ed),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Iconsax.location,
                                color: Color(0xFF4b8e4b),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Address",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFedf4ed),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Iconsax.card,
                                color: Color(0xFF4b8e4b),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Payment",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFf5f5f5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Iconsax.document_text,
                                color: Color(0xFF4b8e4b),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              "Summary",
                              style: TextStyle(fontSize: 14),
                            ),
                            const SizedBox(
                              height: 5,
                            )
                          ],
                        )
                      ],
                    )
                  ]),
                ),
              ),
            ),
            DecoratedSliver(
              decoration: const BoxDecoration(color: Colors.white),
              sliver: SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    const Text("Item Details", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                    const SizedBox(height:10),
                    const ItemCard(
                      imgUrl: 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg', name: 'Long Plant Name', price: 59000, quantity: 2),
                    const ItemCard(
                      imgUrl: 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg', name: 'Long Plant Name', price: 59000, quantity: 2),
                    const Text("Delivery Address", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                    const SizedBox(height: 10),
                    const AddressCard2(address: 'Home', detail: '42 Nguyen Thi Thap, Phuong Tan Quy, Quan 7, TP HCM'),
                    const Text("Payment Details", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                    const PaymentCard2(card: "XXX XXXX XXXX 0701"),
                    const Text("Order Summary", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),  
                  ]),
                ),
              ),
            ),
            const DecoratedSliver(
              decoration: BoxDecoration(color: Colors.white),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
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
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7)))),
                    child: const Text(
                      "Pay Now",
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