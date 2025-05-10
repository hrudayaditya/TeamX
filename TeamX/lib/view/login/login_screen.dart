import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _countryCodeController = TextEditingController();
  bool isTncRead = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/teamx-logo.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
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
                        "Phone Verification",
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "We need to register your phone Number",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(width: 10),
                            SizedBox(
                              width: 40,
                              child: TextField(
                                controller: _countryCodeController,
                                keyboardType: TextInputType.number,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "+91",
                                ),
                              ),
                            ),
                            const Text(
                              "|",
                              style: TextStyle(
                                fontSize: 33.0,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _phoneNumberController,
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Phone",
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(10),
                                ],
                              ),
                            )
                          ],
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
                            // Handle continue button press
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
