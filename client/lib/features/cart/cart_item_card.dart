import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/cart/cart_provider.dart';
import 'package:provider/provider.dart';

class CustomCard2 extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;
  int quantity;

  CustomCard2({super.key,
    required this.name,
    required this.type,
    required this.price,
    required this.imgUrl,
    required this.id,
    this.quantity = 0,});

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {

  final f = NumberFormat.currency(
    locale: "vi_VN",
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shadowColor: Colors.transparent,
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(7, 7, 20, 7),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 0, 0),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                  bottomRight: Radius.circular(50),
                  topRight: Radius.circular(7),
                ),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(40), // Image radius
                  child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150,
                    child: Text(
                      widget.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        f.format(widget.price).replaceFirst("VND", ""),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 12,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      Provider.of<CartProvider>(
                                          context, listen: false)
                                          .decreaseQuantity(widget.id);
                                    },
                                    child: const Icon(
                                      Iconsax.minus,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  )),
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 15),
                                child: Center(
                                  child: Text(
                                    '${widget.quantity}'.padLeft(2,"0"),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                  radius: 12,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      padding: EdgeInsets.zero,
                                    ),
                                    onPressed: () {
                                      Provider.of<CartProvider>(
                                          context, listen: false)
                                          .increaseQuantity(widget.id);
                                    },
                                    child: const Icon(
                                      Iconsax.add,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
