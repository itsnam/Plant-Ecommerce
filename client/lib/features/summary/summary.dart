import 'package:flutter/material.dart';
import 'package:plantial/features/commons/icon_with_label.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/commons/custom_button.dart';
import 'package:plantial/features/summary/custom_item_card.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Checkout',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 50),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
          },
        ),
      ),
      
      body: ListView(
        children: [
          const SizedBox(height: 14),
          const SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconWithLabel(icon: Iconsax.location, label: 'Address', isGreen: true),
                IconWithLabel(icon: Iconsax.card, label: 'Payment', isGreen: true),
                IconWithLabel(icon: Iconsax.document_text, label: 'Summary', isGreen: true),
              ],
            ),
          ),
          
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              'Item Details',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: const [
                CustomItemCard(
                  imgUrl: 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg',
                  name: "Cactus",
                  price: 59000,
                  quantity: 2,
                ),
                CustomItemCard(
                  imgUrl: 'https://i.pinimg.com/564x/4c/b7/8f/4cb78f96241714fb1d7447bbdacc3162.jpg',
                  name: "Cactus2",
                  price: 59000,
                  quantity: 3,
                ),
              ],
            ),
          ),
          // Your other widgets can go here
        ],
        
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 56.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Add any additional bottom navigation items here
              Expanded(
                child: CustomButton(
                  onTap: () {
                    // Handle button press
                  },
                  buttonText: 'Next',
                ),
              ),
              // Example of FloatingActionButton at the end
            ],
          ),
        ),
      ),
    );
  }
}
