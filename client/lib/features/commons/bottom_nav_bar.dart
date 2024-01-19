import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTapped;
  BottomNavBar({super.key, required this.onTapped, required this.index});

  final List<BottomNavigationBarItem> navItems = [
    const BottomNavigationBarItem(
        icon :Icon(Iconsax.home_2),
        activeIcon: Icon(Iconsax.home_25),
        label: 'Home'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.heart),
        activeIcon: Icon(Iconsax.heart5),
        label: 'Favourites'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.shopping_cart),
        activeIcon: Icon(Iconsax.shopping_cart5),
        label: 'Cart'
    ),
    const BottomNavigationBarItem(
        icon: Icon(Iconsax.profile_circle),
        activeIcon: Icon(Iconsax.profile_circle5),
        label: 'Profile'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: BottomNavigationBar(
        backgroundColor: const Color(0xFFffffff),
        type: BottomNavigationBarType.fixed,
        iconSize: 24,
        items: navItems,
        onTap: onTapped,
        currentIndex: index,
        selectedItemColor: const Color(0xFF4b8e4b),
        unselectedItemColor: const Color(0xFF0e110e),
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }
}
