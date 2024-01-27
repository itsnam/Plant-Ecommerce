import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AddressCard extends StatefulWidget {
  final String address;
  final String? selectedAddress;
  final Function onChanged;
  final String addressDetail;

  const AddressCard({
    super.key,
    required this.address,
    required this.onChanged,
    required this.selectedAddress, required this.addressDetail,
  });

  @override
  State<AddressCard> createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
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
            Expanded(
              child: RadioListTile(
                title: Text(
                  widget.address,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                value: widget.address,
                groupValue: widget.selectedAddress,
                onChanged: (value) => widget.onChanged(value),
                subtitle: Text(widget.addressDetail, style: const TextStyle(fontSize: 14),),
              ),
            ), 
            const RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                  height: 30,
                  child: Icon(
                    Iconsax.more,
                    size: 20,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
