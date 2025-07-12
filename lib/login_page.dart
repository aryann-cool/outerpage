import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui'; // For BackdropFilter

import 'signup_page.dart'; // Import the signup page

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://user-images.githubusercontent.com/13468728/233847739-219cb494-c265-4554-820a-bd3424c59065.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15), // Increased blur for 55px effect
                child: Container(
                  width: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Email Input
                      _buildInputBox(
                        controller: _emailController,
                        labelText: 'Email',
                        icon: FontAwesomeIcons.solidEnvelope, // Changed to solid envelope for visibility
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 30),
                      // Password Input
                      _buildInputBox(
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: FontAwesomeIcons.lock,
                        obscureText: true,
                      ),
                      const SizedBox(height: 15),
                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle forgot password
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // Login Button
                      _buildAuthButton(
                        text: 'Log in',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // Handle login
                          print('Login with Email: ${_emailController.text}, Password: ${_passwordController.text}');
                        },
                      ),
                      const SizedBox(height: 15),
                      // Login with Google Button
                      _buildAuthButton(
                        text: 'Login with Google',
                        backgroundColor: const Color(0xffdb4437), // Google red
                        textColor: Colors.white,
                        icon: FontAwesomeIcons.google,
                        onPressed: () {
                          // Handle Google login
                          print('Login with Google');
                        },
                      ),
                      const SizedBox(height: 25),
                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(color: Colors.white, fontSize: 14.4),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.4,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
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
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 310),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 20.0), // Adjust icon vertical alignment
            child: FaIcon(icon, color: Colors.white, size: 19.2), // 1.2rem
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: const EdgeInsets.fromLTRB(5, 20, 35, 0), // Adjust padding
        ),
      ),
    );
  }

  Widget _buildAuthButton({
    required String text,
    required Color backgroundColor,
    required Color textColor,
    IconData? icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        minimumSize: const Size(double.infinity, 40), // width: 100%, height: 40px
        elevation: 0, // Remove shadow
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return backgroundColor.withOpacity(0.8); // Hover effect
            }
            return null; // Defer to the widget's default.
          },
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0), // Remove default vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              FaIcon(icon, size: 20.8), // 1.3rem
              const SizedBox(width: 10),
            ],
            Text(
              text,
              style: const TextStyle(
                fontSize: 16, // 1rem
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
