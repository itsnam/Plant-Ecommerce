import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';

class CustomCard extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;

  const CustomCard({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    const itemWidth = 240.0;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailLayout(productId: widget.id),
          ),
        );
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
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),

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
                          widget.name,
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
                              'đ${widget.price}',
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
