import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:plantial/features/Url/url.dart';

class OTPPage extends StatefulWidget {
  final String email;

  const OTPPage({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  bool isOTPValid = true;
  bool clearText = false;
  bool isResendEnabled = false;
  int resendTimer = 30;
  
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startResendTimer();
  }

  void startResendTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      
      if (resendTimer > 0) {
        setState(() {
          resendTimer--;
        });
      } else {
        setState(() {
          isResendEnabled = true;
          _timer.cancel();
        });
      }
    });
  }

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
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7))
            ),
            title: const Text('Thất bại'),
            content: Text(response.body),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('CLOSE', style: TextStyle(color: Colors.black, fontSize: 18),),
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
            content: const Text('Đã gửi lại mã OTP'),
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
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7))
            ),
            backgroundColor: Colors.white,
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
        backgroundColor: Colors.transparent,
        toolbarHeight: 70,
        leading: const CustomBackButton(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontSize: 16),
                children: <TextSpan>[
                  const TextSpan(
                      text: "Nhập mã OTP với 6 chữ số đã được gửi tới "),
                  TextSpan(
                      text: widget.email,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            OtpTextField(
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              numberOfFields: 6,
              borderWidth: 3.0,
              fieldWidth: 50,
              clearText: clearText,
              styles: [
                Theme.of(context).textTheme.headlineSmall,
                Theme.of(context).textTheme.headlineSmall,
                Theme.of(context).textTheme.headlineSmall,
                Theme.of(context).textTheme.headlineSmall,
                Theme.of(context).textTheme.headlineSmall,
                Theme.of(context).textTheme.headlineSmall,
              ],
              borderColor: const Color(0xFF512DA8),
              showFieldAsBox: true,
              focusedBorderColor: Colors.black,
              onCodeChanged: (String code) {},
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              onSubmit: (String verificationCode) {
                if (isOTPValid) {
                  verifyOTP(context, verificationCode);
                }
              }, // end onSubmit
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: isResendEnabled ? () {
                generateOTP(context);
                setState(() {
                  isResendEnabled = false;
                  resendTimer = 30;
                });
                startResendTimer();
              } : null, // <-- Đã sửa lỗi ở đây
              child: Text(
                resendTimer > 0 ? "Gửi lại OTP (${resendTimer}s)" : "Gửi lại OTP",
                style: TextStyle(
                  fontSize: 18,
                  color: isResendEnabled ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
