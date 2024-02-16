import 'package:flutter/material.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {


  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse(apiPlants));

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
            return const Center(child: CircularProgressIndicator());
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
                    'My favourites',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 700,
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


