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
import 'package:plantial/features/profile/history_cart_item.dart';
import 'package:plantial/features/styles/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Url/url.dart';
import '../commons/custom_back_button.dart';

class HistoryCartPage extends StatefulWidget {
  final String email;
  const HistoryCartPage({Key? key, required this.email}) : super(key: key);

  @override
  State<HistoryCartPage> createState() => _HistoryCartPageState();
}

class _HistoryCartPageState extends State<HistoryCartPage> {

  Future fetchData() async {
    final response = await get(Uri.parse('$apiOrders/history/${widget.email}'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      return data;
    } else {
      return "";
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
              return const Scaffold(body: CustomScrollView(slivers: [
                SliverAppBar(
                  toolbarHeight: 70,
                  backgroundColor: background,
                  leading: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: CustomBackButton(
                      color: Colors.black,
                    ),
                  ),
                  centerTitle: true,
                  title: Text("Lịch sử đơn hàng",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
                  pinned: true,
                  floating: true,
                  snap: false,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text("Bạn chưa mua hàng"),
                  ),
                )
              ]));
            } else {
                final List<dynamic> orders = snapshot.data as List<dynamic>;
                return Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        toolbarHeight: 70,
                        backgroundColor: background,
                        leading: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: CustomBackButtonWithFunction(
                            color: Colors.black,
                            onPressed: () {
                              // Handle back button action here
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        centerTitle: true,
                        title: const Text(
                          "Lịch sử mua hàng",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        pinned: true,
                        floating: true,
                        snap: false,
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        sliver: SliverList.builder(
                          itemCount: orders.length,
                          itemBuilder: (BuildContext context, int index) {
                            final order = orders[index];
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: order['plants'].isNotEmpty
                                  ? HistoryCartItem(
                                      id: order['plants'][0]['_id']['_id'],
                                      idCart: order['_id'],
                                      total: order['total'],
                                      imgUrl: order['plants'][0]['_id']['image'],
                                      status: order['status'],
                                    )
                                  : Container(),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
          }),
    );
  }
}
