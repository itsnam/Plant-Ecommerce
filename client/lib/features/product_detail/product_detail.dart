import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/product.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  const ProductDetail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    var f = NumberFormat.currency(locale: "vi_VN");
    double screenSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Text(
                    "₫${f.format(widget.product.price).replaceFirst("VND", "").trim()}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 15),
            (widget.product.description == "")
                ? const SizedBox()
                : LimitedBox(
                    maxWidth: screenSize,
                    child: Text(
                      widget.product.description,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500),
                    ),
                  ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Đã bán",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(widget.product.sold.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900))
                  ],
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Kho",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(widget.product.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
