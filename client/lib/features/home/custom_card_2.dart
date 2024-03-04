import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard2 extends StatefulWidget {
  final String name;
  final String type;
  final int price;
  final String imgUrl;
  final String id;
  final int quantity;

  const CustomCard2(
      {super.key,
      required this.name,
      required this.type,
      required this.price,
      required this.imgUrl,
      required this.id,
      required this.quantity});

  @override
  State<CustomCard2> createState() => _CustomCard2State();
}

class _CustomCard2State extends State<CustomCard2> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.transparent,
      color: Colors.transparent,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10), // Image border
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(50), // Image radius
                    child: Image.network(widget.imgUrl, fit: BoxFit.cover),
                  ),
                ),
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
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'đ${widget.price * widget.quantity}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: Row(
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFaeb3ae),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          bottomLeft: Radius.circular(5))),
                                ),
                                onPressed: null,
                                child: const Text("-"),
                              )),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                color: Color(0xFFaeb3ae),
                                width: 1,
                              ),
                              bottom: BorderSide(
                                color: Color(0xFFaeb3ae),
                                width: 1,
                              ),
                            )),
                            height: 25,
                            width: 30,
                            child: Center(
                              child: Text(
                                '${widget.quantity}',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Color(0xFFaeb3ae),
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(5),
                                          bottomRight: Radius.circular(5))),
                                ),
                                onPressed: null,
                                child: const Text("+"),
                              )),
                        ],
                      )),
                      Row(children: [
                        SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor: const Color(0xFFffe5e3)),
                              onPressed: null,
                              child: const Icon(
                                Iconsax.trash,
                                color: Color(0xFFff7f74),
                                size: 18,
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
    );
  }
}
