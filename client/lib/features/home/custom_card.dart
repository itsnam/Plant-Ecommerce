import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;

  const CustomCard({
    Key? key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail');
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Card(
          shadowColor: Colors.transparent,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(100), // Image radius
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                LimitedBox(
                  maxWidth: 200,
                  child: Text(
                    widget.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  widget.type,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xFF9AA09A)),
                ),
                const SizedBox(height: 8.0),
                SizedBox(
                  width: 200,
                  child: Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'đ${widget.price}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: const Color(0xFF4b8e4b)),
                              onPressed: () {
                                print('Button clicked');
                              },
                              child: const Icon(
                                Iconsax.shopping_cart,
                                color: Colors.white,
                                size: 20,
                              )),
                        )
                      ],
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
