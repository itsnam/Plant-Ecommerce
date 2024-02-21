import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/Url/url.dart';

class OTPPage extends StatefulWidget {
  final String email;

  const OTPPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final TextEditingController otpController = TextEditingController();
  bool isOTPValid = true;

  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true);
    prefs.setString('email', widget.email);
  }

  Future<void> verifyOTP(BuildContext context, String otp) async {
    final response = await post(
      Uri.parse('$apiAuth/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
        'OTP': otp,
      }),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      await saveLoginState(); 
      if (!context.mounted) return;
      Navigator.popUntil(context, ModalRoute.withName('/home'));
      Navigator.pushReplacementNamed(context, "/home");
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

  Future<void> generateOTP(BuildContext context) async {
    final response = await post(
      Uri.parse('$apiAuth/generate-otp'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': widget.email,
      }),
    );

    if (!context.mounted) return;

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('OTP'),
            content: const Text('Đã gửi OTP'),
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

  bool validateOTP(String otp) {
    String otpRegex = r'^[0-9]{6}$';
    RegExp regExp = RegExp(otpRegex);
    return regExp.hasMatch(otp);
  }

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
            Text(
              "Nhập mã OTP với 6 chữ số đã được gửi tới ${widget.email}",
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(
                hintText: '000000',
                hintStyle: TextStyle(color: Color(0xFFd9e1e1), fontSize: 18),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              onChanged: (value) {
                setState(() {
                  isOTPValid = validateOTP(value);
                });
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  generateOTP(context);
                },
                child: const Text(
                  "Gửi lại OTP",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
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
                  if (otpController.text.isNotEmpty && isOTPValid) {
                    verifyOTP(context, otpController.text.trim());
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
            ),
          ],
        ),
      ),
    );
  }
}
