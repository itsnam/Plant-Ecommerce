import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String name = 'Xương rồng';
  String category = 'Indoor Plant';
  int price = 59000;
  String imgUrl =
      'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg';

  @override
  Widget build(BuildContext context) {
    const itemWidth = 240.0;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Card(
          shadowColor: Colors.transparent,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(7)), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(120), // Image radius
                    child: Image.network(imgUrl, fit: BoxFit.cover),
                  ),
                ),
                LimitedBox(
                  maxWidth: itemWidth,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 20),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'đ$price',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                            ),
                            SizedBox(
                              height: 45,
                              width: 45,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5)),
                                      backgroundColor: const Color(0xFF4b8e4b)),
                                  onPressed: () {

                                  },
                                  child: const Icon(
                                    Iconsax.shopping_cart,
                                    color: Colors.white,
                                    size: 20,
                                  )),
                            )
                          ],
                        ),
                      ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
