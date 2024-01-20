import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/product_detail/product_detail.dart';

class ProductDetailLayout extends StatefulWidget {
  const ProductDetailLayout({super.key});

  @override
  State<ProductDetailLayout> createState() => _ProductDetailLayoutState();
}

class _ProductDetailLayoutState extends State<ProductDetailLayout> {
  String imgUrl =
      'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg';

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 66,
              leading: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const BackButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(CircleBorder()),
                        iconSize: MaterialStatePropertyAll(24),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                  ),
                ),
              ),
              pinned: false,
              floating: true,
              snap: false,
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              actions: [
                TextButton(
                    style: TextButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white),
                    onPressed: null,
                    child: const Icon(
                      Iconsax.heart,
                      color: Colors.black,
                      size: 24,
                    )),
              ],
              flexibleSpace: Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(imgUrl),
                      )),
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SliverFillRemaining(
              child: ProductDetail(),
            )
          ],
        ),
      ),
    );
  }
}
