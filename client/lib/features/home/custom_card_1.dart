import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard1 extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;

  const CustomCard1({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
  }) : super(key: key);

  @override
  State<CustomCard1> createState() => _CustomCard1State();
}

class _CustomCard1State extends State<CustomCard1> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail', arguments: widget.id);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Card(
          shadowColor: Colors.transparent,
          color: Colors.white,
          surfaceTintColor: Colors.white,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(50), // Image radius
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(width: 15.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        widget.type,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
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
                              'đ${widget.price}',
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
      ),
    );
  }
}
