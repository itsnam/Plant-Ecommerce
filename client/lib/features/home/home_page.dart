import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  Future<List<dynamic>> fetchSoldSortedData() async {
    final response = await http.get(Uri.parse(apiPlants));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      data.sort((a, b) =>
          b['sold'].compareTo(a['sold']));
      return data;
    } else {
      throw Exception('Failed to load sold sorted data');
    }
  }

  Future<List<dynamic>> fetchData() async {

    final response = await http.get(Uri.parse(apiPlants));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      data.sort((a, b) =>
          DateTime.parse(b['createdAt']).compareTo(DateTime.parse(a['createdAt'])));
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: Future.wait([fetchSoldSortedData(), fetchData()]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<dynamic> soldSortedData = snapshot.data![0];
            List<dynamic> data = snapshot.data![1];
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Text(
                    'Find Your Favourite Plants Here',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 16),
                const Padding(padding: EdgeInsets.fromLTRB(20, 0, 20, 0), child: CustomSearchBar()),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Most Popular',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: null,
                          child: const Text(
                            'View all',
                            style: TextStyle(color: Color(0xFF4b8e4b)),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 345,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    itemCount: soldSortedData.length,
                    controller: mainListController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard(
                        name: soldSortedData[index]['name'], 
                        type: soldSortedData[index]['type'],
                        price: soldSortedData[index]['price'],
                        imgUrl: soldSortedData[index]['image']
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
                        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: null,
                          child: const Text(
                            'View all',
                            style: TextStyle(color: Color(0xFF4b8e4b)),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 345,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard1(
                        id: data[index]['_id'],
                        name: data[index]['name'], 
                        type: data[index]['type'],
                        price: data[index]['price'],
                        imgUrl: data[index]['image']
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
              ],
            );
          }
        },
      ),
    );
  }
}
