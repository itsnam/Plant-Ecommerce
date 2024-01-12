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
  List<CustomCard> list = [const CustomCard(), const CustomCard(), const CustomCard(), const CustomCard(),];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            controller: scrollController,
            children: [
              const Text(
                'Find Your Favourite Plants Here',
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16),
              const CustomSearchBar(),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Popular',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: null,
                      child: const Text(
                        'View all',
                        style: TextStyle(color: Color(0xFF4b8e4b)),
                      )
                  )
                ],
              ),
              const SizedBox(height: 8),
              LimitedBox(
                maxHeight: 375,
                child: ListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: list,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'New products',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.w600 , fontSize: 18),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      onPressed: null,
                      child: const Text(
                        'View all',
                        style: TextStyle(color: Color(0xFF4b8e4b)),
                      )
                  )
                ],
              ),
              const SizedBox(height: 8),
              ListView(
                controller: scrollController,
                shrinkWrap: true,
                children: const [
                  CustomCard1(),
                  CustomCard1(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
