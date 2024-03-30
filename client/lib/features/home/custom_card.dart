import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/product_detail/product_detail_layout.dart';

import '../../models/product.dart';

class CustomCard extends StatefulWidget {
  final Product product;

  const CustomCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isLoggedIn = false;
  String? email;

  @override
  Widget build(BuildContext context) {
    const itemWidth = 300.0;
    final f = NumberFormat.currency(locale: "vi_VN");
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailLayout(product: widget.product),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 7, 0),
        child: Card(
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          surfaceTintColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    // Image border
                    child: SizedBox(
                      height: itemWidth,
                      width: itemWidth * 0.85,
                      child: Image.network(
                          '$imageUrl${widget.product.imgUrl}',
                          fit: BoxFit.cover),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Colors.black.withAlpha(0),
                            Colors.black12,
                            Colors.black12,
                            Colors.black45
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 7, 30, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: itemWidth - 75,
                                  child: Text(
                                    widget.product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Color(0xFFf9f9f9),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  f.format(widget.product.price),
                                  style: const TextStyle(
                                      color: Color(0xFFf9f9f9),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20),
                                ),
                              ]),
                        ],
                      ),
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
