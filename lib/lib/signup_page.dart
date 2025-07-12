import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui'; // For BackdropFilter

import 'login_page.dart'; // Import the login page

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
                  width: 500, // max-width: 500px for signup card
                  padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 16.0), // 0.7rem vertical padding
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Username Input
                      _buildInputBox(
                        controller: _usernameController,
                        labelText: 'Username',
                        icon: FontAwesomeIcons.solidUser,
                      ),
                      const SizedBox(height: 30),
                      // Email Input
                      _buildInputBox(
                        controller: _emailController,
                        labelText: 'Email',
                        icon: FontAwesomeIcons.solidEnvelope,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 30),
                      // Phone Number Input
                      _buildInputBox(
                        controller: _phoneController,
                        labelText: 'Ph. number',
                        icon: FontAwesomeIcons.mobileAlt, // Using a suitable phone icon
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 30),
                      // Password Input
                      _buildInputBox(
                        controller: _passwordController,
                        labelText: 'Password',
                        icon: FontAwesomeIcons.lock,
                        obscureText: true,
                      ),
                      const SizedBox(height: 25),
                      // Sign Up Button
                      _buildAuthButton(
                        text: 'Sign Up',
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        onPressed: () {
                          // Handle signup
                          print('Sign Up with: Username: ${_usernameController.text}, Email: ${_emailController.text}, Phone: ${_phoneController.text}, Password: ${_passwordController.text}');
                        },
                      ),
                      const SizedBox(height: 15),
                      // Sign Up with Google Button
                      _buildAuthButton(
                        text: 'Sign Up with Google',
                        backgroundColor: const Color(0xffdb4437), // Google red
                        textColor: Colors.white,
                        icon: FontAwesomeIcons.google,
                        onPressed: () {
                          // Handle Google signup
                          print('Sign Up with Google');
                        },
                      ),
                      const SizedBox(height: 25),
                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(color: Colors.white, fontSize: 14.4),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const LoginPage()),
                              );
                            },
                            child: const Text(
                              'Login',
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
      constraints: const BoxConstraints(maxWidth: 400), // max-width for input boxes in signup
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
