import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/address/address.dart';
import 'package:plantial/features/address/addressList.dart';
import 'package:plantial/features/address/address_detail_page.dart';
import 'package:plantial/features/address/address_card.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/profile/profile_page.dart';
import 'package:plantial/features/styles/styles.dart';

class UpdateAddressPage extends StatefulWidget {
  final String email;

  const UpdateAddressPage({
    super.key,
    required this.email,
  });

  @override
  State<UpdateAddressPage> createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {
  AddressList addressList = AddressList();
  Address? selectedAddress;
  Future? _future;

  onChangeAddress(value) {
    setState(() {
      selectedAddress = value;
    });
  }

  refreshPage() {
    setState(() {
      _future = fetchData();
    });
  }

  Future fetchData() async {
    final response = await get(
      Uri.parse('$apiAddress/${widget.email}'),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.length > 0) {
        setState(() {
          addressList = AddressList.fromJson(data);
          selectedAddress = addressList.items[0];
        });
      }
      return "success";
    }
  }

  @override
  void initState() {
    super.initState();
    _future = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.white,
              leading: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: CustomBackButton(
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              title: Text("Địa chỉ",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
              pinned: false,
              floating: true,
              snap: false,
            ),
            FutureBuilder(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(primary),
                      )),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(primary),
                      )),
                    );
                  } else {
                    return DecoratedSliver(
                      decoration: const BoxDecoration(color: Colors.white),
                      sliver: SliverPadding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        sliver: SliverList.builder(
                          itemCount: addressList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AddressCard(
                              address: addressList.items[index],
                              onChanged: onChangeAddress,
                              selectedAddress: selectedAddress,
                              onDelete: refreshPage,
                            );
                          },
                        ),
                      ),
                    );
                  }
                }),
            SliverToBoxAdapter(
              child: Container(
                height: 55,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddressDetail(
                                      appBarTitle: "Địa chỉ mới",
                                      email: widget.email)))
                          .then((value) => refreshPage());
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(primary),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)))),
                    child: const Text(
                      "Thêm địa chỉ giao hàng",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
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
                      Navigator.pop(context);
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
