import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plantial/features/home/custom_card_1.dart';
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
    return Scaffold(
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
            return const Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    CustomCard1(
                        name: 'name',
                        category: 'category',
                        price: 20,
                        imgUrl:
                        'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg'),
                    CustomCard1(
                        name: 'name',
                        category: 'category',
                        price: 20,
                        imgUrl:
                        'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg')
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
