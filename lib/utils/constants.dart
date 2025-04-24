import 'package:flutter/material.dart';

class AppColors {
  // Colores principales - Paleta elegante
  static const Color primary = Color(0xFF0A2342); // Azul marino oscuro
  static const Color primaryDark = Color(0xFF051428); // Azul marino más oscuro
  static const Color primaryLight = Color(0xFF2C3E50); // Azul grisáceo

  // Colores de acento - Dorado y metálicos
  static const Color accent = Color(0xFFD4AF37); // Dorado
  static const Color accentLight = Color(0xFFE5CB68); // Dorado claro
  static const Color accentDark = Color(0xFFAA8C2C); // Dorado oscuro

  // Grises elegantes
  static const Color grey = Color(0xFF9E9E9E);
  static const Color greyLight = Color(0xFFF5F5F5); // Crema
  static const Color greyDark = Color(0xFF424242); // Gris carbón

  // Colores para habitaciones
  static const Color livingRoom = Color(0xFF1A365D);
  static const Color livingRoomActive = Color(0xFF2C5282);

  static const Color kitchen = Color(0xFF1E3A5F);
  static const Color kitchenActive = Color(0xFF3182CE);

  static const Color bedroom = Color(0xFF153E75);
  static const Color bedroomActive = Color(0xFF2B6CB0);

  static const Color bathroom = Color(0xFF1E3A8A);
  static const Color bathroomActive = Color(0xFF3B82F6);

  // Color de texto
  static const Color textDark = Color(0xFF2D3748);
  static const Color textLight = Color(0xFFF7FAFC);
  static const Color textMuted = Color(0xFF718096);
}

class AppTextStyles {
  // Estilo elegante para títulos principales
  static const TextStyle elegantHeading1 = TextStyle(fontFamily: 'Playfair Display', fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 1.0, height: 1.2, color: AppColors.textDark);

  // Estilos de título
  static const TextStyle heading1 = TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 1.5, height: 1.2, color: AppColors.textDark);

  static const TextStyle heading2 = TextStyle(fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 0.5, height: 1.3, color: AppColors.textDark);

  static const TextStyle heading3 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.3, height: 1.4, color: AppColors.textDark);

  // Estilos de cuerpo de texto
  static const TextStyle body = TextStyle(fontSize: 16, height: 1.5, color: AppColors.textDark);

  static const TextStyle bodyLarge = TextStyle(fontSize: 18, height: 1.6, color: AppColors.textDark);

  static const TextStyle bodySmall = TextStyle(fontSize: 14, height: 1.5, color: AppColors.textMuted);

  // Estilos para botones
  static const TextStyle button = TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: AppColors.accent);

  static const TextStyle buttonSmall = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.2, color: AppColors.accent);

  // Estilos de etiquetas y textos pequeños
  static const TextStyle caption = TextStyle(fontSize: 12, color: AppColors.textMuted, height: 1.4, letterSpacing: 0.2);

  // Estilos para características
  static const TextStyle feature = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.5, color: AppColors.textLight);
}

class AppSizes {
  static const double navBarHeight = 80;
  static const double sectionSpacing = 80;
  static const double contentPadding = 50;
  static const double cardRadius = 4; // Más pequeño para un aspecto más elegante
  static const double buttonRadius = 2; // Casi rectos para botones elegantes
  static const double imageRadius = 4; // Bordes sutiles para imágenes
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

// Decoraciones reutilizables
class AppDecorations {
  // Botón elegante
  static ButtonStyle elegantButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: AppColors.accent,
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.buttonRadius), side: const BorderSide(color: AppColors.accent, width: 1.5)),
    textStyle: const TextStyle(fontSize: 14, letterSpacing: 2.0, fontWeight: FontWeight.w500),
  );

  // Contenedor de característica elegante
  static BoxDecoration featureBox = BoxDecoration(color: Colors.transparent, border: Border.all(color: AppColors.accent.withOpacity(0.7), width: 1), borderRadius: BorderRadius.circular(AppSizes.cardRadius));

  // Fondo degradado elegante
  static BoxDecoration elegantGradient = BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.primary, AppColors.primaryLight]));

  // Sombra sutil para elementos
  static List<BoxShadow> subtleShadow = [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8, offset: const Offset(0, 4))];
}
