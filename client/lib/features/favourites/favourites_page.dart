import 'package:flutter/material.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home/custom_card_3.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  bool isLoggedIn = false;
  String? email;
  bool isLoading = true;

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

  void onFavoriteRemoved() {
    setState(() {
      isLoading = true;
    });
    fetchData().then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: const Text('Yêu thích', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
      ),
      body: isLoggedIn
          ? FutureBuilder<List<dynamic>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Color(0xFF4b8e4b)),
                  ));
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text('Chưa có cây yêu thích'),
                  );
                } else {
                  List<dynamic> data = snapshot.data!;
                  return ListView(
                    children: [
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
                            itemCount: data.length,
                            itemBuilder: (_, index) {
                              return CustomCard3(
                                  id: data[index]['plantId']['_id'],
                                  name: data[index]['plantId']['name'],
                                  type: data[index]['plantId']['type'],
                                  price: data[index]['plantId']['price'],
                                  imgUrl:
                                  'http://10.0.2.2:3000/${data[index]['plantId']['image']}');
                            }),
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
