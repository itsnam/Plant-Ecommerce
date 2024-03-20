import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/payment/payment_method.dart';
import 'package:plantial/features/styles/styles.dart';

class PaymentCard extends StatefulWidget {
  final PaymentMethod paymentMethod;
  final PaymentMethod? selectedPaymentMethod;
  final Function onChanged;

  const PaymentCard({
    super.key,
    required this.paymentMethod,
    required this.onChanged,
    required this.selectedPaymentMethod,
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
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            border: Border.all(width: 0.75, color: unselectedMenuItem)),
        child: Row(
          children: [
            SizedBox(width: 50, child: widget.paymentMethod.icon),
            Expanded(
              child: RadioListTile(
                activeColor: primary,
                title: Text(
                  widget.paymentMethod.name,
                  style: const TextStyle(fontSize: 14),
                ),
                controlAffinity: ListTileControlAffinity.trailing,
                value: widget.paymentMethod,
                groupValue: widget.selectedPaymentMethod,
                onChanged: (value) => widget.onChanged(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
