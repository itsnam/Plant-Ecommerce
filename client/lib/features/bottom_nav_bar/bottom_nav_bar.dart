import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTapped;
  BottomNavBar({super.key, required this.onTapped, required this.index});

  final List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(icon :Icon(Iconsax.home_2), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Iconsax.heart), label: 'Favourites'),
    const BottomNavigationBarItem(icon: Icon(Iconsax.search_normal), label: 'Search'),
    const BottomNavigationBarItem(icon: Icon(Iconsax.shopping_cart), label: 'Cart'),
    const BottomNavigationBarItem(icon: Icon(Iconsax.profile), label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: navItems,
      onTap: onTapped,
      currentIndex: index,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
    );
  }
}
