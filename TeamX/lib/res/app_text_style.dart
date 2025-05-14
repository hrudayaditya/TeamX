import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text style configurations for the TeamX Fantasy Sports application
///
/// This file contains:
/// 1. Custom text styles for different UI elements
/// 2. Font size and weight configurations
/// 3. Color schemes for text
/// 4. Style variations (primary, secondary, tertiary)
class AppTextStyles {
  AppTextStyles(double d, MaterialColor red, FontWeight bold);

  static TextStyle primaryStyle<T>(
      double fontSize, Color color, FontWeight fontWeight) {
    if (fontSize != null) {
      return GoogleFonts.assistant(
          fontSize: fontSize, color: color, fontWeight: fontWeight);
    }
    return GoogleFonts.assistant(color: color, fontWeight: fontWeight);
  }

  static TextStyle secondaryStyle<T>(
      double fontSize, Color color, FontWeight fontWeight) {
    return GoogleFonts.assistant(
        fontSize: fontSize, color: color, fontWeight: fontWeight);
  }

  static TextStyle terniaryStyle<T>(
      double fontSize, Color color, FontWeight fontWeight) {
    return GoogleFonts.poppins(
        fontSize: fontSize, color: color, fontWeight: fontWeight);
  }
}
