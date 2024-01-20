import 'package:flutter/material.dart';
import 'package:plantial/features/address/address_page.dart';
import 'package:plantial/features/cart/cart_page.dart';
import 'package:plantial/features/favourites/favourites_page.dart';
import 'features/bottom_nav_bar/bottom_nav_bar.dart';
import 'features/home/home_page.dart';
import 'features/profile/profile_page.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int index = 0;
  List<Widget> pages = [const HomePage(), const FavouritePage(), const AddressPage(), const ProfilePage()];

  void onTapped(int i){
    setState(() {
      index = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFECECEC),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)
        )
      ),
      home: ScrollConfiguration(
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
      ),
    );
  }
}