import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../styles/styles.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTapped;

  BottomNavBar({super.key, required this.onTapped, required this.index});

  final List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.home_25),
        activeIcon: Icon(Iconsax.home_25),
        label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.heart5),
        activeIcon: Icon(Iconsax.heart5),
        label: 'Favourites'),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.shopping_cart5),
        activeIcon: Icon(Iconsax.shopping_cart5),
        label: 'Cart'),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.profile_circle5),
        activeIcon: Icon(Iconsax.profile_circle5),
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 7,
          blurRadius: 5,
          offset: const Offset(0, 3),
        )
      ]),
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        iconSize: 26,
        items: navItems,
        onTap: onTapped,
        currentIndex: index,
        selectedItemColor: primary,
        unselectedItemColor: unselectedMenuItem,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
