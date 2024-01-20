import 'package:flutter/material.dart';
import 'package:plantial/features/custom_text_field/custom_text_field.dart';
import 'package:plantial/features/custom_button/custom_button.dart';
import 'package:plantial/features/sign_up/sign_up_page.dart';
import 'package:plantial/features/forgort_password/forgot_password_page.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
           child: Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo và dòng chữ "Welcome to Plantial"
                Image.asset('assets/images/logo.png', height: 100),
                const Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
                const Text(
                  'Plantial',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF4b8e4b),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),

                // Input Email Address
                const CustomTextField(
                  hintText: 'Email Address',
                ),

                // Input Password and visibility icon
                CustomTextField(
                  hintText: 'Password',
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      // Toggle password visibility
                    },
                  ),
                ),

                // Forgot password?
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to forgot password page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordPage()), // Replace SignUpPage() with the actual class name
                        );
                      },
                      child: const Text(
                        'Forgot password?',
                        style: TextStyle(
                          color: Color(0xFF4b8e4b),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Button Login
                CustomButton(
                  onTap: () {
                    //Handle
                  },
                  buttonText: 'Login',
                ),
                const SizedBox(height: 15),

                // Or continue with social account
                const Text(
                  'Or continue with social account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),

                // Buttons Google and Facebook
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Google login
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      label: const Text('Google'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Handle Facebook login
                      },
                      icon: const Icon(Icons.facebook),
                      label: const Text('Facebook'),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Didn't have account? Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Didn't have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()), // Replace SignUpPage() with the actual class name
                        );
                        // Navigate to sign-up page
                      },
                      child: const Text(
                        'Register',
                        style: TextStyle(
                          color: Color(0xFF4b8e4b),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


