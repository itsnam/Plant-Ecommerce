import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/features/authentication/otp_page.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/styles/styles.dart';

class SignInWithEmail extends StatefulWidget {
  const SignInWithEmail({Key? key}) : super(key: key);

  @override
  State<SignInWithEmail> createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {
  final TextEditingController emailController = TextEditingController();
  bool isEmailValid = true;

  Future<void> generateOTP(BuildContext context) async {
    final email = emailController.text.trim();
    final response = await post(
      Uri.parse('$apiAuth/generate-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
      }),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPPage(email: emailController.text.trim()),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Lỗi'),
            content: Text(response.body),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _validateEmail(String email) {
    String emailRegex =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(emailRegex);
    return regExp.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: const CustomBackButton(color: Colors.black,),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              autofocus: true,
              cursorColor: Colors.black,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'example@gmail.com',
                hintStyle: const TextStyle(color: Color(0xFFd9e1e1)),
                errorText: isEmailValid ? null : 'Invalid email format',
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  isEmailValid = _validateEmail(value);
                });
              },
            ),
            Expanded(child: Container()),
            Container(
              height: 55,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              child: TextButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty && isEmailValid) {
                    generateOTP(context);
                  }
                },
                child: const Text(
                  "Tiếp tục",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
