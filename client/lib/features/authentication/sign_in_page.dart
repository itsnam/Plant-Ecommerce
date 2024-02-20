import 'package:flutter/material.dart';
import 'package:plantial/features/authentication/sign_in_with_email.dart';
import 'package:plantial/features/commons/custom_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                Image.asset('assets/images/logo.png', height: 85),
                const Text(
                  'Plantial',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF4b8e4b),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20 , 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInWithEmail()));
                    },
                    buttonText: 'Tiếp tục với email',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
