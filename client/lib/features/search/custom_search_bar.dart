import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});
  @override
  Widget build(BuildContext context) {
    return const SearchBar(
      hintText: 'Search',
      hintStyle: MaterialStatePropertyAll(TextStyle(color: Color(0xFFAEB3AE))),
      padding: MaterialStatePropertyAll(EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0)),
      surfaceTintColor: MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: MaterialStatePropertyAll(Color(0xFFFFFFFF)),
      shape: MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
      )),
      shadowColor: MaterialStatePropertyAll(Colors.transparent),
      leading: IconButton(
        icon: Icon(Iconsax.search_normal, size: 20, color: Colors.black,),
        onPressed: null,
      ),
      trailing: [
        IconButton(
            onPressed: null,
            icon: Icon(Iconsax.camera, color: Colors.black,)
        )
      ],
    );
  }
}
