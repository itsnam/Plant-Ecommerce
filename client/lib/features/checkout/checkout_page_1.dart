import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/checkout/address_card.dart';


import 'checkout_page_2.dart';

class CheckOutPage1 extends StatefulWidget {
  final List<String> addresses;
  final List<String> addressesDetail;
  const CheckOutPage1(
      {super.key, this.addresses = const ["Home", "Work", "Other"],
        this.addressesDetail = const [
        '42 Nguyen Thi Thap, Phuong Tan Quy, Quan 7, TP HCM',
        '67 Tran Huong Dao, Quan 1, TP HCM',
        '897/23 Ho Tung Mau, Phuong My Long, TP Long Xuyen'
      ] });

  @override
  State<CheckOutPage1> createState() => _CheckOutPage1State();
}

class _CheckOutPage1State extends State<CheckOutPage1> {
  late String? selectedAddress = widget.addresses[0];

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
                                  color: const Color(0xFFf5f5f5),
                                  borderRadius: BorderRadius.circular(5)),
                              child: const Icon(
                                Iconsax.card,
                                color: Color(0xFF262926),
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
                    AddressCard(
                      address: widget.addresses[0], onChanged: onChangeAddress, selectedAddress: selectedAddress, addressDetail: widget.addressesDetail[0],),
                    AddressCard(
                      address: widget.addresses[1], onChanged: onChangeAddress, selectedAddress: selectedAddress, addressDetail: widget.addressesDetail[1],),
                    AddressCard(
                      address: widget.addresses[2], onChanged: onChangeAddress, selectedAddress: selectedAddress, addressDetail: widget.addressesDetail[2],),
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
                          "Add New Address",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const CheckOutPage2()));
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
