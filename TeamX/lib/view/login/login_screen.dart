import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:teamx/res/app_url.dart';
import 'package:teamx/utils/utils.dart'; // Adjust the path if needed
import 'package:teamx/view/fantasy/contest_screen.dart'; // Add this import

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isTncRead = false;

  Future<void> _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final response = await http.post(
      Uri.parse(AppUrl.loginEndPint),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final jwt = data['token'] ?? '';
      final username = data['username'] ?? '';
      final emailFromResponse = data['email'] ?? email;

      // Store values securely
      await Utils().secureStorage.write(key: 'jwt', value: jwt);
      await Utils().secureStorage.write(key: 'email', value: emailFromResponse);
      await Utils().secureStorage.write(key: 'username', value: username);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );

      // Navigate to ContestScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ContestScreen()),
      );
    } else if (response.statusCode == 409) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Incorrect email or password.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid login credentials.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 25, right: 25),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Image.asset(
                    'assets/teamx-logo.png',
                    height: height * 0.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.4),
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Please enter your email and password",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      // Email Field
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Field
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Password",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Sign Up Button below password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle sign up navigation
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: isTncRead,
                            onChanged: (bool? value) {
                              setState(() {
                                isTncRead = value!;
                              });
                            },
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: 'By tapping Continue, you agree to our ',
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black,
                                ),
                                children: <TextSpan>[
                                  const TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: ' and ',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (isTncRead) {
                              _login();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please accept Terms and Conditions')),
                              );
                            }
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
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
