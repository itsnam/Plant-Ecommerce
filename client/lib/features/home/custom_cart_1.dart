import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard1 extends StatefulWidget {
  const CustomCard1({super.key});

  @override
  State<CustomCard1> createState() => _CustomCard1State();
}

class _CustomCard1State extends State<CustomCard1> {
  String name = 'Cactus';
  String category = 'Indoor Plant';
  int price = 59000;
  String imgUrl = 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg';
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10), // Image border
              child: SizedBox.fromSize(
                size: const Size.fromRadius(50), // Image radius
                child: Image.network(imgUrl, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),),
                  const SizedBox(height: 7.0),
                  Text(category, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFF9AA09A)),),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('đ$price', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                      SizedBox(
                        height: 35,
                        width: 35,
                        child: TextButton(
                            style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: const Color(0xFF4b8e4b)
                            ),
                            onPressed: null,
                            child: const Icon(Iconsax.arrow_right_3, color: Colors.white, size: 16,)
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
