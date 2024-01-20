import 'package:flutter/material.dart';
import 'package:plantial/features/custom_text_field/custom_text_field.dart';
import 'package:plantial/features/custom_button/custom_button.dart';
import 'package:plantial/features/sign_in/sign_in_page.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

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
                  'Reset your Password',
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
                
                // Input Email Address
                const CustomTextField(
                  hintText: 'Email Address',
                ),

                // Input OTP
                Container(
                  width: 320,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF4b8e4b),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'OTP',
                              contentPadding: EdgeInsets.all(10),
                              isCollapsed: true,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add your logic to generate OTP here
                          // You can use setState to trigger a rebuild or perform any other necessary actions
                        },
                        child: const Text('Generate OTP'),
                      ),
                    ],
                  ),
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
                  buttonText: 'Reset Password',
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