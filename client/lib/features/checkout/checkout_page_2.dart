import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/checkout/payment_card.dart';
import 'package:plantial/features/checkout/checkout_page_3.dart';

class CheckOutPage2 extends StatefulWidget {
  final List<String> card;
  const CheckOutPage2(
      {super.key, this.card = const ["XXX XXXX XXXX 0701", "XXX XXXX XXXX 5221", 'COD'],});

  @override
  State<CheckOutPage2> createState() => _CheckOutPage2State();
}

class _CheckOutPage2State extends State<CheckOutPage2> {
  late String? selectedAddress = widget.card[0];

  onChangeAddress(value){
    setState(() {
      selectedAddress = value;
    });
  }

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
                                color: Color(0xFF262926),
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
                    const Text("Save Cards", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                    const SizedBox(height:10),
                    PaymentCard(
                      card: widget.card[0], onChanged: onChangeAddress, selectedCard: selectedAddress),
                    PaymentCard(
                        card: widget.card[1], onChanged: onChangeAddress, selectedCard: selectedAddress),
                    SizedBox(
                      height: 55,
                      child: TextButton(
                        onPressed: null,
                        style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color(0xFF4b8e4b)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7)))),
                        child: const Text(
                          "Add New Card",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                    const Text("Other Methods", style: (TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),),
                    const SizedBox(height: 10),
                    PaymentCard(
                        card: widget.card[2], onChanged: onChangeAddress, selectedCard: selectedAddress),
                  ]),
                ),
              ),
            ),
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
          child: Expanded(
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutPage3()));
                      },
                      style: ButtonStyle(
                          backgroundColor:
                          const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)))),
                      child: const Text(
                        "Next",
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
      ),
    );
  }
}
