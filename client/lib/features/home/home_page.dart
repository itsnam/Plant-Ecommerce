import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/home/custom_card.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'package:plantial/features/search/custom_search_bar.dart';

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
        data.sort((a, b) => DateTime.parse(b['createdAt']).compareTo(DateTime.parse(a['createdAt'])));
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
        filteredData = data.where((item) =>
            item['name'].toLowerCase().contains(keyword.toLowerCase()) ||
            item['type'].toLowerCase().contains(keyword.toLowerCase())).toList();
        soldSortedData = filteredData.toList()..sort((a, b) => b['sold'].compareTo(a['sold']));
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
        body: isLoading ? const Center(child: CircularProgressIndicator( valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),))
            : data.isEmpty ? const Center(child: Text('No data available'))
            : NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  }
                  return true;
                },
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text(
                        'Find Your Favourite Plants Here',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CustomSearchBar(onSearch: filterData),
                    ),
                    const SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Most Popular',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              onPressed: null,
                              child: const Text(
                                'View all',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: Color(0xFF4b8e4b)),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 360,
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
                            imgUrl: 'http://10.0.2.2:3000/${soldSortedData[index]['image']}'
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'New products',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: null,
                            child: const Text(
                              'View all',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: Color(0xFF4b8e4b)),
                            )
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                        itemCount: filteredData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CustomCard1(
                            id: filteredData[index]['_id'],
                            name: filteredData[index]['name'],
                            type: filteredData[index]['type'],
                            price: filteredData[index]['price'],
                            imgUrl: 'http://10.0.2.2:3000/${filteredData[index]['image']}'
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
      ),
    );
  }
}
