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
      if (await checkLoginStatus()) {
        if (!context.mounted) return;
        Navigator.pushNamed(context, '/cart');
      } else {
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
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
          body: pages.elementAt(index),
          bottomNavigationBar: BottomNavBar(
            index: index,
            onTapped: onTapped,
          )),
    );
  }
}
