import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  final List<CustomCard> list = [
    const CustomCard(),
    const CustomCard(),
    const CustomCard(),
    const CustomCard(),
  ];

  Future<List<dynamic>> fetchData() async {
    const String apiUrl = 'https://jsonplaceholder.typicode.com/photos';
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            List<dynamic> data = snapshot.data!;
            return ListView(
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
                const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: CustomSearchBar()),
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
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    controller: mainListController,
                    scrollDirection: Axis.horizontal,
                    children: list,
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
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CustomCard1(
                          name: data[index]['title'],
                          category: data[index]['title'],
                          price: data[index]['id'],
                          imgUrl: data[index]['thumbnailUrl']);
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
