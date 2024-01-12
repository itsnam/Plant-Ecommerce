import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class CustomCard extends StatefulWidget {
  const CustomCard({super.key});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  String name = 'Cactus';
  String category = 'Indoor Plant';
  int price = 59000;
  String imgUrl = 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg';

  @override
  Widget build(BuildContext context) {
    return Card(
        shadowColor: Colors.grey,
        color: Colors.white,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
          child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(100), // Image radius
                      child: Image.network(imgUrl, fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                  const SizedBox(height: 7.0),
                  Text(category, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: Color(0xFF9AA09A)),),
                  const SizedBox(height: 12.0),
                  SizedBox(
                    width: 200,
                    child: Expanded(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('đ$price', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),),
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                      backgroundColor: const Color(0xFF4b8e4b)
                                  ),
                                  onPressed: null,
                                  child: const Icon(Iconsax.arrow_right_3, color: Colors.white, size: 20,)
                              ),
                            )
                          ],
                        ),
                    ),
                  ),
                ],
              ),
          ),
          ),
    );
  }
}
