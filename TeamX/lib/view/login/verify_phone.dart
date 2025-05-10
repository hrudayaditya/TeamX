import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:teamx/res/app_text_style.dart';
import 'package:teamx/res/color.dart';
import 'package:teamx/utils/utils.dart';
import 'package:teamx/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
import 'package:telephony/telephony.dart';

class VerifyPhoneScreen extends StatefulWidget {
  final String phoneNumber;

  const VerifyPhoneScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<VerifyPhoneScreen> createState() => _VerifyPhoneScreenState();
}

onBackgroundMessage(SmsMessage message) {
  print("onBackgroundMessage called");
}

class _VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  final TextEditingController otpController = TextEditingController();
  final telephony = Telephony.instance;
  String _message = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  }

  onMessage(SmsMessage message) async {
    if (message.body!.contains('GP Plus')) {
      final otpDigits = message.body!.substring(0, 6).split('');
      setState(() {
        otpDigits.forEach((digit) {
          otpController.text += digit;
        });
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final bool? result = await telephony.requestPhoneAndSmsPermissions;

    if (result != null && result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) {
      return;
    }
  }

  // final FocusNode _otpFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/playaway_logo.png',
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
                    'assets/playaway_full.png',
                    height: height * 0.5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.4),
                      const Text(
                        "Otp Verification",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Please enter the otp you received on: ${widget.phoneNumber}",
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      Pinput(
                        autofocus: true,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        controller: otpController,
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
                            // Handle verify button press
                          },
                          child: const Text(
                            "Verify Phone Number",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          "Edit Phone Number ?",
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.black,
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

  void verifyOtp(BuildContext context, bool redirectToReferScreen,
      AuthViewModel authViewModel) {
    String otp = otpController.text.trim();
    // Verify if the OTP is valid (optional)
    if (otp.length == 6) {
      // If the OTP is valid, proceed with verification
      Map<String, dynamic> data = {
        'phone_number': widget.phoneNumber,
        'otp': otp,
      };

      // Now call the verifyOTP method from the authViewModel
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      authViewModel.verifyOTP(data, context, redirectToReferScreen);
      // _otpController.clear();
    } else {
      // Show an error message if the OTP is not valid
      Fluttertoast.showToast(
          msg: "Please enter a valid 6-digit OTP.",
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          gravity: ToastGravity.TOP);
      authViewModel.setLoading(false);
    }
  }
}

class CountdownTimer extends StatefulWidget {
  final String phone_number;
  const CountdownTimer({super.key, required this.phone_number});

  @override
  CountdownTimerState createState() => CountdownTimerState();
}

class CountdownTimerState extends State<CountdownTimer> {
  int _seconds = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _seconds > 0
        ? Text(
            'Resend OTP in $_seconds s',
            style: AppTextStyles.primaryStyle(
                14.0, AppColors.black, FontWeight.normal),
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors
                  .primaryColor, // Set the background color here // Set the background color here
            ),
            onPressed: () {
              Map data = {
                'phone_number': widget.phone_number,
              };

              final authViewModel =
                  Provider.of<AuthViewModel>(context, listen: false);
              authViewModel.sendOTP(data, context);
              setState(() {
                _seconds = 60;
              });
              startTimer();
            },
            child: Text(
              'Resend OTP',
              style: AppTextStyles.primaryStyle(
                  14.0, AppColors.black, FontWeight.normal),
            ),
          );
  }
}
