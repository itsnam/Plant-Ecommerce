import 'package:flutter/material.dart';
import 'package:plantial/features/commons/bottom_nav_bar.dart';
import 'package:plantial/features/favourites/favourites_page.dart';
import 'package:plantial/features/profile/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_page.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index = 0;
  List<Widget> pages = [
    const HomePage(),
    const FavouritePage(),
    const Text("123"),
    const ProfilePage()
  ];

  Future<bool> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;

  }

  Future<void> onTapped(int i) async {
    if (i == 2) {
      if(await checkLoginStatus()){
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/cart');
      }else{
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/auth');
      }
    } else {
      setState(() {
        index = i;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Scaffold(
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return [
                  const SliverPadding(padding: EdgeInsets.all(20)),
                  SliverAppBar(
                    titleSpacing: 20,
                    backgroundColor: const Color(0xFFf5f5f5),
                    title: const Text(
                      'Plantial',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                    pinned: false,
                    floating: true,
                    snap: false,
                    forceElevated: innerBoxIsScrolled,
                  ),
                  const SliverPadding(padding: EdgeInsets.all(5)),
                ];
              },
              body: pages.elementAt(index),
            ),
            bottomNavigationBar: BottomNavBar(
              index: index,
              onTapped: onTapped,
            )),
      ),
    );
  }
}
