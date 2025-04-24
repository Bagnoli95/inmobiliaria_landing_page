import 'package:flutter/material.dart';

class AppColors {
  // Colores principales
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryDark = Color(0xFF0D47A1);
  static const Color primaryLight = Color(0xFFE3F2FD);

  // Colores secundarios
  static const Color secondary = Color(0xFF4CAF50);
  static const Color secondaryDark = Color(0xFF2E7D32);
  static const Color secondaryLight = Color(0xFFE8F5E9);

  // Colores de acento
  static const Color accent = Color(0xFFFFA000);
  static const Color accentDark = Color(0xFFF57C00);
  static const Color accentLight = Color(0xFFFFECB3);

  // Grises
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF5F5F5);
  static const Color greyDark = Color(0xFF616161);

  // Colores para habitaciones
  static const Color livingRoom = Color(0xFFE3F2FD);
  static const Color livingRoomActive = Color(0xFF2196F3);

  static const Color kitchen = Color(0xFFE8F5E9);
  static const Color kitchenActive = Color(0xFF4CAF50);

  static const Color bedroom = Color(0xFFEDE7F6);
  static const Color bedroomActive = Color(0xFF673AB7);

  static const Color bathroom = Color(0xFFE0F2F1);
  static const Color bathroomActive = Color(0xFF009688);
}

class AppTextStyles {
  static const TextStyle heading1 = TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 1.5, height: 1.2);

  static const TextStyle heading2 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.5, height: 1.3);

  static const TextStyle heading3 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4);

  static const TextStyle body = TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF616161));

  static const TextStyle bodySmall = TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF757575));

  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.2);

  static const TextStyle caption = TextStyle(fontSize: 12, color: Color(0xFF9E9E9E), height: 1.4);
}

class AppSizes {
  static const double navBarHeight = 80;
  static const double sectionSpacing = 80;
  static const double contentPadding = 50;
  static const double cardRadius = 8;
  static const double buttonRadius = 8;
  static const double imageRadius = 8;
}

class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve standard = Curves.easeInOut;
  static const Curve emphasized = Curves.easeOutCubic;
  static const Curve decelerated = Curves.easeOutCirc;
  static const Curve accelerated = Curves.easeInCubic;
}
