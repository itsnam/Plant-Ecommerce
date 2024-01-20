import 'package:flutter/material.dart';
import 'package:plantial/features/commons/icon_with_label.dart';
import 'package:iconsax/iconsax.dart';
import 'package:plantial/features/commons/custom_button.dart';
import 'package:plantial/features/summary/custom_item_card.dart';
import 'package:plantial/features/summary/custom_item_card1.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  ScrollController scrollController = ScrollController();
  EdgeInsetsGeometry horizontalPadding = EdgeInsets.symmetric(horizontal: 20.0);

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
        controller: scrollController,
        shrinkWrap: true,
        children: [
          const SizedBox(height: 8),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              'Delivery Address',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: const [
                CustomItemCard1(
                  name: 'John',
                  detail: 'Chi tiết',
                  nextpage: '/address',
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              'Payment details',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              controller: scrollController,
              shrinkWrap: true,
              children: const [
                CustomItemCard1(
                  name: 'John',
                  detail: 'Số tài khoản',
                  nextpage: '/payment',
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Text(
              'Order Summary',
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),

          // Item total
          Padding(
            padding: horizontalPadding,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Item total', style: TextStyle(fontWeight: FontWeight.w400)),
                Text('đ118000', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          const SizedBox(height: 4),
      
          // Discount
          Padding(
            padding: horizontalPadding,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Discount', style: TextStyle(fontWeight: FontWeight.w400)),
                Text('đ10000', style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          const SizedBox(height: 4),
          // Shipping Charge

          Padding(
            padding: horizontalPadding,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Charge', style: TextStyle(fontWeight: FontWeight.w400)),
                Text('đ20000', style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),

          // Separator Line
          Padding(
            padding: horizontalPadding,
            child: Container(
              height: 1.0,
              color: Colors.black, // Choose the color you prefer
              margin: const EdgeInsets.symmetric(vertical: 8.0),
            ),
          ),

          // Grand Total
          Padding(
            padding: horizontalPadding,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Grand Total', style: TextStyle(fontWeight: FontWeight.w700)),
                Text('đ128000', style: TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
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
                  buttonText: 'Pay now',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
