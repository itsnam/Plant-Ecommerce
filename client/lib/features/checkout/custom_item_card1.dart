import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomItemCard1 extends StatelessWidget {
  final String name;
  final String detail;
  final String nextpage;

  const CustomItemCard1({
    Key? key,
    required this.name,
    required this.detail,
    required this.nextpage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          detail,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, nextpage);
                  },
                  child: const Icon(
                    Iconsax.edit,
                    color: Color(0xFF4b8e4b),
                    size: 24.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
