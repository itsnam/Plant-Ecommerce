import 'package:flutter/material.dart';
import 'package:plantial/features/authentication/sign_in_page.dart';
import 'package:plantial/features/commons/custom_button.dart';
import 'package:plantial/features/commons/custom_text_field.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo và dòng chữ "Register Account to Plantial"
                Image.asset('assets/images/logo.png', height: 100),

                const Text(
                  'Register Account',
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'to ',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'Plantial',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF4b8e4b),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                
                // Input Name
                const CustomTextField(
                  hintText: 'Name',
                ),

                // Input Email Address
                const CustomTextField(
                  hintText: 'Email Address',
                ),

                // Input password and visibility icon
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

                // Input Confirm Password and visibility icon
                CustomTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      // Toggle password visibility
                    },
                  ),
                ),
                const SizedBox(height: 10),
                
                // Button SignUp
                CustomButton(
                  onTap: () {
                    //Handle
                  },
                  buttonText: 'Register',
                ),
                const SizedBox(height: 10),
                
                // Or continue with social account
                const Text(
                  'Or continue with social account',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                
                // Buttons Google và Facebook
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
                const SizedBox(height: 10),
                
                // Didn't have account? Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign-up page
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                      child: const Text(
                        'Login',
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