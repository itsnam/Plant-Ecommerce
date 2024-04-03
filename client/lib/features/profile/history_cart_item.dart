import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:plantial/features/profile/history_cart_detail.dart';

class HistoryCartItem extends StatefulWidget {
  final String idCart;
  final int total;
  final String imgUrl;
  final String id;
  final int status;

  const HistoryCartItem({super.key,
    required this.idCart,
    required this.total,
    required this.imgUrl,
    required this.id,
    required this.status});

  @override
  State<HistoryCartItem> createState() => _HistoryCartItemState();
}

class _HistoryCartItemState extends State<HistoryCartItem> {

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
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HistoryCartDetail(id: widget.idCart),
            ),
          );
        },
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
                    child: Image.network('http://10.0.2.2:3000/${widget.imgUrl}', fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(width: 15.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Đơn hàng: ${widget.idCart}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tổng: ${f.format(widget.total).replaceFirst("VND", "")}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Text(
                              (widget.status == 2)
                                  ? 'Đang duyệt'
                                  : (widget.status == 3)
                                      ? 'Đã duyệt'
                                      : 'Hủy đơn',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (widget.status == 2)
                                    ? Colors.black
                                    : (widget.status == 3)
                                        ? Colors.green
                                        : Colors.red,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              (widget.status == 2)
                                  ? Icons.access_time
                                  : (widget.status == 3)
                                      ? Icons.check_circle
                                      : Icons.cancel,
                              color: (widget.status == 2)
                                  ? Colors.black
                                  : (widget.status == 3)
                                      ? Colors.green
                                      : Colors.red,
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
      ),
    );
  }
}
