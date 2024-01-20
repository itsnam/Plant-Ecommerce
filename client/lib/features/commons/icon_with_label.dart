import 'package:flutter/material.dart';

class IconWithLabel extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isGreen;

  const IconWithLabel({
    Key? key,
    required this.icon,
    required this.label,
    this.isGreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Icon(
            icon, // Use the provided icon
            size: 30,
            color: isGreen ? const Color(0xFF4b8e4b) : null,
            
          ),
          const SizedBox(height: 10),
          Text(
            label,
          ),
        ],
      ),
    );
  }
}