import 'package:flutter/material.dart';
import 'package:plantial/features/cart/cart_page.dart';
import 'package:plantial/features/favourites/favourites_page.dart';
import 'features/bottom_nav_bar/bottom_nav_bar.dart';
import 'features/home/home_page.dart';
import 'features/profile/profile_page.dart';
import 'features/sign_in/sign_in_page.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  List<Widget> pages = [const HomePage(), const FavouritePage(), const CartPage(), const ProfilePage()];

  void onTapped(int i){
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: const TextTheme()
      ),
      home: Scaffold(
          backgroundColor: const Color(0xFFF5F5F5),
          appBar: AppBar(
            titleSpacing: 24.0,
            title: const Text(
              'Plantial',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          body: Center(
            child: pages.elementAt(index),
          ),
          bottomNavigationBar: BottomNavBar(
            index: index,
            onTapped: onTapped,
          )
      ),
    );
  }
}