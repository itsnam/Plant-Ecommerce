import 'package:flutter/material.dart';
import 'package:plantial/features/search/custom_search_bar.dart';
import 'package:plantial/features/home/custom_cart_1.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final ScrollController scrollController = ScrollController();

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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              'My favourites',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
        ],
      ),
    );
  }
}


