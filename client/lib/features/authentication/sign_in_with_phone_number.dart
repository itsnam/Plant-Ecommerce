import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantial/features/authentication/otp_page.dart';

class SignInWithPhoneNumber extends StatefulWidget {
  const SignInWithPhoneNumber({super.key});

  @override
  State<SignInWithPhoneNumber> createState() => _SignInWithPhoneNumberState();
}

class _SignInWithPhoneNumberState extends State<SignInWithPhoneNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Phone number",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextField(
                decoration: const InputDecoration(
                    hintText: '99 123 4567',
                    hintStyle: TextStyle(color: Color(0xFFd9e1e1))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ]),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const OTPPage()));
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
