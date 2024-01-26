import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter the 6-digit code sent to 99123456 by SMS",
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: '000000',
                  hintStyle: TextStyle(color: Color(0xFFd9e1e1), fontSize: 18),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
            const SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Resend SMS",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
            Expanded(child: Container()),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF4b8e4b),
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.popUntil(context, ModalRoute.withName('/home'));
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
