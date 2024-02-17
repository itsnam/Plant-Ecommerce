import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/product_detail/product_detail.dart';
import 'package:http/http.dart';

class ProductDetailLayout extends StatefulWidget {
  final String productId;
  const ProductDetailLayout({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailLayout> createState() => _ProductDetailLayoutState();
}

class _ProductDetailLayoutState extends State<ProductDetailLayout> {
  
  dynamic data; 

  Future<void> fetchSingleData() async {
    final response = await get(Uri.parse('$apiPlants/${widget.productId}'));

    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSingleData();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        body: data == null ? const Center(child: CircularProgressIndicator())
        : data.isEmpty ? const Center(child: Text('No data available'))
        : CustomScrollView(
          slivers: [
            SliverAppBar(
              leadingWidth: 66,
              leading: const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: BackButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(CircleBorder()),
                    iconSize: MaterialStatePropertyAll(24),
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                  ),
                ),
              ),
              pinned: false,
              floating: true,
              snap: false,
              expandedHeight: MediaQuery.of(context).size.width * 0.8,
              actions: [
                IconButton(
                  onPressed: () {
                    // Handle heart icon tap
                  },
                  icon: const Icon(
                    Iconsax.heart,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
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
                      image: NetworkImage(data['image']),
                    ),
                  ),
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
            SliverFillRemaining(
              hasScrollBody: false,
              child: ProductDetail( 
                name: data['name'],
                description: data['description'],
                sold: data['sold'],
                quantity: data['quantity'],
                price: data['price'],
              ),
            ),
          ],
        ),
        bottomNavigationBar: data == null ? null : Container(
          height: 80,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: TextButton(
              onPressed: () {
                // Handle add to cart button tap
              },
              style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(Color(0xFF4b8e4b)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                )),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Add to Cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const VerticalDivider(),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    data['price'].toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
