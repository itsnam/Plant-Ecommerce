import 'package:flutter/material.dart';
import 'package:plantial/features/commons/bottom_nav_bar.dart';
import 'package:plantial/features/favourites/favourites_page.dart';
import 'package:plantial/features/profile/profile_page.dart';
import 'package:plantial/features/summary/summary_page.dart';
import 'home_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> pages = [const HomePage(), const FavouritePage(), const SummaryPage(), const ProfilePage()];

  void onTapped(int i){
    setState(() {
      index = i;
    });
  }
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
              return [
                SliverAppBar(
                  titleSpacing: 20,
                  backgroundColor: const Color(0xFFECECEC),
                  title: const Text('Plantial', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
                  pinned: false,
                  floating: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
                )
              ];
            }, body: pages.elementAt(index),
          ),
          bottomNavigationBar: BottomNavBar(
            index: index,
            onTapped: onTapped,
          )
      ),
    );
  }
}
