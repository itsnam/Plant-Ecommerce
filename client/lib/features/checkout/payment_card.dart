import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PaymentCard extends StatefulWidget {
  final String card;
  final String? selectedCard;
  final Function onChanged;

  const PaymentCard({
    super.key,
    required this.card,
    required this.onChanged,
    required this.selectedCard,
  });

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
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
                offset: const Offset(0, 3), // changes position of shadow
              )
            ]),
        child: Row(
          children: [
            SizedBox(
                width: 50,
                child: widget.card == "COD"
                    ? const Icon(
                        Iconsax.dollar_square,
                        size: 20,
                      )
                    : const Icon(
                        Iconsax.card,
                        size: 20,
                      )),
            Expanded(
              child: RadioListTile(
                title: Text(
                  widget.card,
                  style: const TextStyle(fontSize: 14),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: widget.card,
                groupValue: widget.selectedCard,
                onChanged: (value) => widget.onChanged(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
