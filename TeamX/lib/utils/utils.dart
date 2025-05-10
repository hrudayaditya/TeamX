import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:teamx/res/color.dart';
import 'package:intl/intl.dart';

class Utils {
  final secureStorage = FlutterSecureStorage();

  static formatPrice(double price) => '${price.toStringAsFixed(2)}';
  static formatDate(DateTime date) => DateFormat.yMd().format(date);
  Future<void> storeDataSecure(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String> fetchDataSecure(String key) async {
    String? storedValue = await secureStorage.read(key: key);

    // Check if the stored value is null or empty
    if (storedValue == null || storedValue.isEmpty) {
      // You can return a default value or throw an exception, depending on your requirements.
      // Here, we're returning an empty string as a default value.
      return '';
    }

    return storedValue;
  }

  Future<void> deleteDataSecure(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> resetDataSecure() async {
    await secureStorage.deleteAll();
  }

  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  static void flushBarErrorMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP);
    // showFlushbar(
    //   context: context,
    //   flushbar: Flushbar(
    //     forwardAnimationCurve: Curves.decelerate,
    //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    //     padding: const EdgeInsets.all(15),
    //     message: message,
    //     duration: const Duration(seconds: 3),
    //     borderRadius: BorderRadius.circular(8),
    //     flushbarPosition: FlushbarPosition.TOP,
    //     backgroundColor: Colors.red,
    //     reverseAnimationCurve: Curves.easeInOut,
    //     positionOffset: 20,
    //     icon: const Icon(
    //       Icons.error,
    //       size: 28,
    //       color: Colors.white,
    //     ),
    //   )..show(context),
    // );
  }

  static void flushBarMessage(String message, BuildContext context) {
    if (context.widget == null) {
      return;
    }
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.primaryColor,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.check_circle,
          size: 28,
          color: Colors.white,
        ),
      )..show(context),
    );
  }

  static void showMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showModifyBottomSheet(
      BuildContext context, void Function(double, int) onModify) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      context: context,
      builder: (BuildContext context) {
        double modifiedPrice = 0.0;
        int modifiedSize = 0; // Changed the type to int

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Modify Order',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        modifiedPrice = double.tryParse(value) ?? modifiedPrice;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Size'),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        modifiedSize = int.tryParse(value) ?? modifiedSize;
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      onModify(modifiedPrice, modifiedSize);
                      Navigator.pop(context);
                    },
                    child: const Text('Modify'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static Widget buildTextWithValue(String value, [num? numericValue]) {
    final color = numericValue != null
        ? (numericValue >= 0 ? Colors.green : Colors.red)
        : null;
    return Text(
      value,
      style: TextStyle(color: color),
    );
  }
}

class Bid {
  final int price;
  final double size;

  Bid({required this.price, required this.size});
}

class Ask {
  final int price;
  final double size;

  Ask({required this.price, required this.size});
}
