import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard1 extends StatefulWidget {
  const CustomCard1({super.key});

  @override
  State<CustomCard1> createState() => _CustomCard1State();
}

class _CustomCard1State extends State<CustomCard1> {
  String name = 'Long Plant Name Abcdefghiklm';
  String category = 'Indoor Plant';
  int price = 59000;
  String imgUrl =
      'https://i.pinimg.com/564x/18/63/11/186311e20163d1d7caa29652d3d5c6a9.jpg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Card(
        shadowColor: Colors.transparent,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Image border
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(45), // Image radius
                  child: Image.network(imgUrl, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      category,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xFF9AA09A)),
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            'đ$price',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16),
                          ),
                        ),
                        Row(children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: const Color(0xFFECECEC)),
                                onPressed: null,
                                child: const Icon(
                                  Iconsax.heart5,
                                  color: Color(0xFF4b8e4b),
                                  size: 16,
                                )),
                          ),
                          const SizedBox(width: 5.0),
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    backgroundColor: const Color(0xFF4b8e4b)),
                                onPressed: null,
                                child: const Icon(
                                  Iconsax.shopping_cart,
                                  color: Colors.white,
                                  size: 16,
                                )),
                          ),
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
