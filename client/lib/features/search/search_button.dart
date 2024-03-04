import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/search/search_page.dart';
import 'package:plantial/features/styles/styles.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Color(0xFFf9f9f9),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SearchPage()));
          },
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0, 8, 5, 8),
            child: Row(
              children: [
                Icon(
                  Iconsax.search_normal,
                  color: unselectedMenuItem,
                  size: 24,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Tìm kiếm",
                  style: TextStyle(
                      color: unselectedMenuItem,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
          )),
    );
  }
}
