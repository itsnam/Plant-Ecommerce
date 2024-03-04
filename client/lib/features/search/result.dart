import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plantial/features/home/custom_card_1.dart';
import 'package:plantial/features/home/custom_card_3.dart';
import 'package:plantial/features/search/upload.dart';

class Result extends StatefulWidget {
  final File image;

  const Result({super.key, required this.image});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: const Text("Kết quả tìm kiếm",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
        ),
        body: FutureBuilder(
          future: upload(widget.image),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
              return Padding(
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: (1 / 1.35),
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CustomCard3(
                      id: data[index]['_id'],
                      name: data[index]['name'],
                      type: data[index]['type'],
                      price: data[index]['price'],
                      imgUrl: 'http://10.0.2.2:3000/${data[index]['image']}',
                      onFavoriteRemoved: null,
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
