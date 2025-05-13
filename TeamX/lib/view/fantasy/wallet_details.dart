import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teamx/res/app_text_style.dart';
import 'package:teamx/res/color.dart';
import 'package:teamx/res/app_url.dart';
import 'package:teamx/utils/utils.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  double walletBalance = 0.0;
  bool isLoading = false;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String? generatedOtp;
  bool showOtpField = false;

  @override
  void initState() {
    super.initState();
    fetchWallet();
  }

  // Fetch wallet details using email from secure storage
  Future<void> fetchWallet() async {
    setState(() {
      isLoading = true;
    });
    try {
      final utils = Utils();
      final email = await utils.fetchDataSecure('email');
      final url = AppUrl.wallet + "?email=$email";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          walletBalance = (data['wallet'] as num).toDouble();
        });
      } else {
        throw Exception("Failed to fetch wallet balance");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error fetching wallet: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Generate a random 4-digit OTP
  String generateOtp() {
    final random = Random();
    int otp = random.nextInt(9000) + 1000;
    return otp.toString();
  }

  // Updated sendOtp method with no SMS provided.
  void sendOtp() async {
    generatedOtp = generateOtp();
    // Simulate OTP sending by showing it in a snackbar.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP (simulated): $generatedOtp")),
    );
    setState(() {
      showOtpField = true;
    });
  }

  // Verify OTP and call API to add money to the wallet
  Future<void> verifyOtpAndAddMoney() async {
    if (otpController.text.trim() == generatedOtp) {
      final double? amountValue = double.tryParse(amountController.text.trim());
      if (amountValue == null || amountValue <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Enter a valid amount")),
        );
        return;
      }
      // Convert to int to avoid .0 in the URL - backend expects an integer.
      final int intAmount = amountValue.toInt();
      
      final utils = Utils();
      final email = await utils.fetchDataSecure('email');
      // Using the provided POST endpoint format with int amount:
      final url = "http://192.168.1.30:8080/auth/wallet/add?email=$email&amount=$intAmount";
      final response = await http.post(Uri.parse(url));
      print("Status: ${response.statusCode}");
      print("Response: ${response.body}");
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Money added successfully")),
        );
        await fetchWallet();
        amountController.clear();
        otpController.clear();
        setState(() {
          showOtpField = false;
          generatedOtp = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to add money")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid OTP")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Wallet",
          style: AppTextStyles.primaryStyle(20, AppColors.white, FontWeight.bold),
        ),
        // Using a solid color for the AppBar background.
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 72, 133, 190),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: fetchWallet,
          )
        ],
      ),
      // Use a white background for the body.
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Wallet Balance Card using the solid color.
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        elevation: 4,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 72, 133, 190),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "Current Balance",
                                style: AppTextStyles.primaryStyle(16, Colors.white, FontWeight.w600),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "\$${walletBalance.toStringAsFixed(2)}",
                                style: AppTextStyles.primaryStyle(28, Colors.white, FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Amount Input Section
                      TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Add Amount",
                          labelStyle: AppTextStyles.primaryStyle(16, AppColors.black, FontWeight.w600),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // OTP and Button Section
                      if (!showOtpField)
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: sendOtp,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 72, 133, 190),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Send OTP",
                              style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.bold),
                            ),
                          ),
                        ),
                      if (showOtpField) ...[
                        TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Enter OTP",
                            labelStyle: AppTextStyles.primaryStyle(16, AppColors.black, FontWeight.w600),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: verifyOtpAndAddMoney,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 72, 133, 190),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Verify OTP & Add Money",
                              style: AppTextStyles.terniaryStyle(16, Colors.white, FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
