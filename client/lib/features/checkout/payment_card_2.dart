import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentCard2 extends StatelessWidget {
  final String card;

  const PaymentCard2({
    Key? key,
    required this.card,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: card == "COD"
                  ? const Icon(
                      Iconsax.dollar_square,
                      size: 20,
                    )
                  : const Icon(
                      Iconsax.card,
                      size: 20,
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                child: Text(
                  card,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: InkWell(
                onTap: () {
                  
                },
                child: const Icon(
                  Iconsax.edit,
                  color: Color(0xFF4b8e4b),
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
