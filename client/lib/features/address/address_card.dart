import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/address/address.dart';
import 'package:plantial/features/styles/styles.dart';

class AddressCard extends StatefulWidget {
  final Address address;
  final Address? selectedAddress;
  final Function onChanged;

  const AddressCard({
    super.key,
    required this.address,
    required this.onChanged,
    required this.selectedAddress,
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
            borderRadius: BorderRadius.circular(7),
            color: Colors.white,
            border: Border.all(color: unselectedMenuItem, width: 0.75)
            ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: RadioListTile(
                  activeColor: primary,
                  title: Text(
                    widget.address.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 14),
                  ),
                  value: widget.address,
                  groupValue: widget.selectedAddress,
                  onChanged: (value) => widget.onChanged(value),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.address.phone, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),),
                      Text(
                        "${widget.address.street}, ${(widget.address.ward[1]).toLowerCase()} ${widget.address.ward[0]}, ${(widget.address.district[1]).toLowerCase()} ${(widget.address.district[0])}, ${(widget.address.province[1]).toLowerCase()} ${widget.address.province[0]}",
                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
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
