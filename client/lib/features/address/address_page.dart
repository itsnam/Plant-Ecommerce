import 'package:flutter/material.dart';
import 'package:plantial/features/icon_with_label/icon_with_label.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/custom_button/custom_button.dart';
import 'package:plantial/features/address/custom_address_card.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
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
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 50),
          ],
        ),
        leading: const BackButton(
          style: ButtonStyle(
            shape: MaterialStatePropertyAll(CircleBorder()),
            iconSize: MaterialStatePropertyAll(24),
            backgroundColor:
              MaterialStatePropertyAll(Colors.white)
          ),
        ),
      ),

      body: ListView(
        children: [
          const SizedBox(height: 10),
          const SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconWithLabel(icon: Iconsax.location, label: 'Address', isGreen: true),
                IconWithLabel(icon: Iconsax.card, label: 'Payment'),
                IconWithLabel(icon: Iconsax.document_text, label: 'Summery'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: const [
                CustomAddressCard(
                  title: "aaaa",
                  subtitle: "asd"
                ),
                CustomAddressCard(
                  title: "aaaa",
                  subtitle: "asd"
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
                    Navigator.pushNamed(context, '/payment');
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
