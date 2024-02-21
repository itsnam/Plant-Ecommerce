import 'package:flutter/material.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool isLoggedIn = false;
  String? email;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      email = prefs.getString('email');
    });
  }

  Future<List<dynamic>> fetchData() async {
    final response = await get(Uri.parse('$apiFavorites/$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn
          ? FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),
                  ));
                } else {
                  List<dynamic> data = snapshot.data!;
                  return ListView(
                    children: [
                      const   Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Text(
                          'My favourites',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 650,
                        child: ListView.builder(
                          padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CustomCard1(
                                id: data[index]['plantId']['_id'],
                                name: data[index]['plantId']['name'],
                                type: data[index]['plantId']['type'],
                                price: data[index]['plantId']['price'],
                                imgUrl:
                                    'http://10.0.2.2:3000/${data[index]['plantId']['image']}');
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  );
                }
              },
            )
          : Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/auth");
                },
                child: const Text('Sign In to view favourites'),
              ),
            ),
    );
  }
}
