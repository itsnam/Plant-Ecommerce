import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomBackButtonWithFunction extends StatelessWidget {
  const CustomBackButtonWithFunction(
      {super.key, this.color = Colors.white, required this.onPressed, });
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.arrow_left_2,
            color: color,
            size: 24,
          )),
    );
  }
}
