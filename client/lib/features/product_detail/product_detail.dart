import 'package:flutter/material.dart';

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
    double screenSize = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 25, 10),
        child: Column(
          children: [
            LimitedBox(
              maxWidth: screenSize,
              child: Text(
                widget.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 24),
            LimitedBox(
              maxWidth: screenSize,
              child: Text(
                widget.description,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            const SizedBox(height: 15),
            const Divider(color: Color(0xFFD9E1E1)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Đã bán",
                        style: TextStyle(
                            color: Color(0xFFAEB3AE),
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(widget.sold.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                  ],
                ),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Kho",
                        style: TextStyle(
                            color: Color(0xFFAEB3AE),
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    const SizedBox(height: 6),
                    Text(widget.quantity.toString(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600))
                  ],
                ),
              ],
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${widget.price}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
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
                                color: Color(0xFFD9E1E1), // your color here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_quantity > 1) _quantity--; // Giảm số lượng
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
                                color: Color(0xFFD9E1E1), // your color here
                              ),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          setState(() {
                            _quantity++; // Tăng số lượng
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
