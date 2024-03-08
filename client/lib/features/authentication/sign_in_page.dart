import 'package:flutter/material.dart';
import 'package:plantial/features/authentication/sign_in_with_email.dart';
import 'package:plantial/features/commons/custom_back_button.dart';
import 'package:plantial/features/commons/custom_button.dart';
import 'package:plantial/features/styles/styles.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: Stack(
        children: [
          ClipRRect(
            child: SizedBox(
              width: width,
              child: Image.asset("assets/images/bg.jpg", fit: BoxFit.cover,)
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              toolbarHeight: 70,
              backgroundColor: Colors.transparent,
              leading: const CustomBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 1,
                  ),
                  const Row(
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome to",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            'Plantial',
                            style: TextStyle(
                              height: 0,
                              fontSize: 75,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomButton(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInWithEmail()));
                    },
                    buttonText: 'Tiếp tục với email',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
