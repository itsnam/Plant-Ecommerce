import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final String description;
  final int sold;
  final int quantity;
  final int price;
  final Function(int) onQuantityUpdated;

  const ProductDetail({
    Key? key,
    required this.name,
    required this.description,
    required this.sold,
    required this.quantity,
    required this.price,
    required this.onQuantityUpdated,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  int _quantity = 1;

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
                  widget.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Text("₫${f.format(widget.price).replaceFirst("VND", "").trim()}",
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 15),
            LimitedBox(
              maxWidth: screenSize,
              child: Text(
                widget.description,
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
                    Text(widget.sold.toString(),
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
                    Text(widget.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFFD9E1E1),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--;
                            widget.onQuantityUpdated(_quantity);
                          });
                        },
                        child: const Text("-"),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                      child: Center(
                        child: Text('$_quantity'),
                      ),
                    ),
                    SizedBox(
                      height: 35,
                      width: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Color(0xFFD9E1E1),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_quantity < widget.quantity) _quantity++;
                            widget.onQuantityUpdated(_quantity);
                          });
                        },
                        child: const Text("+"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
