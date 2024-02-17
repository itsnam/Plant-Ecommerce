import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/search/pick_image.dart';

class CustomSearchBar extends StatelessWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Search',
      hintStyle: const MaterialStatePropertyAll(TextStyle(color: Color(0xFFAEB3AE))),
      padding: const MaterialStatePropertyAll(EdgeInsets.fromLTRB(0.0, 5.0, 5.0, 5.0)),
      surfaceTintColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: const MaterialStatePropertyAll(Color(0xFFFFFFFF)),
      shape: const MaterialStatePropertyAll(ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))
      )),
      shadowColor: const MaterialStatePropertyAll(Colors.transparent),
      leading: const IconButton(
        icon: Icon(Iconsax.search_normal, size: 20, color: Colors.black,),
        onPressed: null,
      ),
      trailing: [
        IconButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PickImage()));
            },
            icon: const Icon(Iconsax.camera, color: Colors.black,)
        )
      ],
      onChanged: (value) {
        onSearch(value);
      },
    );
  }

}
