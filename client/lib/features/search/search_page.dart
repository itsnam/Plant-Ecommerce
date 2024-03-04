import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantial/features/home/custom_card_3.dart';
import 'package:plantial/features/search/custom_search_bar.dart';
import 'package:plantial/features/styles/styles.dart';
import '../Url/url.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List result = [];

  void search(String keywords) async {
    if (keywords == "") return;
    var body = {'keywords': keywords.trim().toLowerCase()};
    var jsonString = json.encode(body);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};
    final response = await post(Uri.parse(apiSearchPlants),
        headers: headers, body: jsonString);
    if (response.statusCode == 200) {
      setState(() {
        result = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: CustomSearchBar(onInput: search),
          backgroundColor: primary,
          leading: const BackButton(
            style: ButtonStyle(iconSize: MaterialStatePropertyAll(20)),
            color: Colors.white,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: GridView.builder(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: (1 / 1.35),
                mainAxisSpacing: 10,
                crossAxisSpacing: 5,
                crossAxisCount: 2),
            itemCount: result.length,
            itemBuilder: (BuildContext context, int index) {
              return CustomCard3(
                  id: result[index]['_id'],
                  name: result[index]['name'],
                  type: result[index]['type'],
                  price: result[index]['price'],
                  imgUrl: 'http://10.0.2.2:3000/${result[index]['image']}');
            },
          ),
        ),
      ),
    );
  }
}
