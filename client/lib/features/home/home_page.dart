import 'package:flutter/material.dart';
import 'package:plantial/features/home/custom_card.dart';
import 'package:plantial/features/home/custom_cart_1.dart';
import 'package:plantial/features/search/custom_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();
  List<CustomCard> list = [
    const CustomCard(),
    const CustomCard(),
    const CustomCard(),
    const CustomCard(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
            height: 355,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(15, 0, 10, 0),
              controller: scrollController,
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
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: const [
                CustomCard1(),
                CustomCard1(),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
