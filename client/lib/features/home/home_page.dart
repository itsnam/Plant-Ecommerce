import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/home/custom_card.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'package:plantial/features/home/custom_card_2.dart';
import 'package:plantial/features/home/custom_card_3.dart';
import 'package:plantial/features/search/custom_search_bar.dart';
import 'package:plantial/features/search/search_button.dart';
import 'package:plantial/features/styles/styles.dart';

import '../search/pick_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController mainListController = ScrollController();

  List<dynamic> data = [];
  List<dynamic> soldSortedData = [];
  List<dynamic> filteredData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await get(Uri.parse(apiPlants));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        data = jsonData;
        data.sort((a, b) => DateTime.parse(b['createdAt'])
            .compareTo(DateTime.parse(a['createdAt'])));
        soldSortedData = List.from(data);
        soldSortedData.sort((a, b) => b['sold'].compareTo(a['sold']));
        filteredData = List.from(data);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void filterData(String keyword) {
    setState(() {
      if (keyword.isEmpty) {
        filteredData = List.from(data);
        soldSortedData = List.from(data);
      } else {
        filteredData = data
            .where((item) =>
                item['name'].toLowerCase().contains(keyword.toLowerCase()) ||
                item['type'].toLowerCase().contains(keyword.toLowerCase()))
            .toList();
        soldSortedData = filteredData.toList()
          ..sort((a, b) => b['sold'].compareTo(a['sold']));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SliverPadding(padding: EdgeInsets.all(20)),
              SliverAppBar(
                titleSpacing: 20,
                backgroundColor: const Color(0xFFececee),
                title: const Text(
                  'Plantial',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
                pinned: false,
                floating: true,
                snap: false,
                forceElevated: innerBoxIsScrolled,
              ),
              const SliverPadding(padding: EdgeInsets.all(5)),
            ];
          },
          body: isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(primary),
                ))
              : data.isEmpty
                  ? const Center(child: Text('No data available'))
                  : NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollUpdateNotification) {
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                        return true;
                      },
                      child: ListView(
                        physics: const ScrollPhysics(),
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                            child: Row(children: [
                              const Expanded(
                                  child: SearchButton()),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PickImage()));
                                  },
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Color(0xFFf9f9f9)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(17),
                                      child: Icon(
                                        size: 24,
                                        Iconsax.camera,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ))
                            ]),
                          ),
                          const SizedBox(height: 18),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phổ biến',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                              itemCount: soldSortedData.length,
                              controller: mainListController,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                return CustomCard(
                                    id: soldSortedData[index]['_id'],
                                    name: soldSortedData[index]['name'],
                                    type: soldSortedData[index]['type'],
                                    price: soldSortedData[index]['price'],
                                    imgUrl:
                                        'http://10.0.2.2:3000/${soldSortedData[index]['image']}');
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Row(
                              children: [
                                const Text(
                                  'Mới',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: null,
                                    child: const Icon(Iconsax.arrow_right5, size: 28, color: unselectedMenuItem))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
                            child: GridView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: (1 / 1.35),
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 5,
                                        crossAxisCount: 2),
                                itemCount: filteredData.length,
                                itemBuilder: (_, index) {
                                  return CustomCard3(
                                      id: soldSortedData[index]['_id'],
                                      name: soldSortedData[index]['name'],
                                      type: soldSortedData[index]['type'],
                                      price: soldSortedData[index]['price'],
                                      imgUrl:
                                          'http://10.0.2.2:3000/${soldSortedData[index]['image']}');
                                }),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
