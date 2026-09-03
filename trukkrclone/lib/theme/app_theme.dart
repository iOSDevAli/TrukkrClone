import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for every color / gradient used across the Trukkr app.
/// Keeping these as named constants means new screens automatically
/// stay visually consistent with the Dashboard.
class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF3F4F6);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);

  // Vehicle status indicator colors
  static const Color running = Color(0xFF22C55E);
  static const Color stopped = Color(0xFFEF4444);
  static const Color idle = Color(0xFFFACC15);
  static const Color offline = Color(0xFF3B82F6);
  static const Color noData = Color(0xFF9CA3AF);
  static const Color expired = Color(0xFF7F1D1D);

  // Alert / menu card gradients (top-left -> bottom-right)
  static const List<Color> geofence = [Color(0xFF7B2FF7), Color(0xFF9B4DFF)];
  static const List<Color> overspeed = [Color(0xFF7B2FF7), Color(0xFFB06CFF)];
  static const List<Color> excessIdle = [Color(0xFF3B82F6), Color(0xFF60A5FA)];
  static const List<Color> excessDriving = [Color(0xFF2563EB), Color(0xFF60A5FA)];
  static const List<Color> ignition = [Color(0xFFEF4444), Color(0xFFF87171)];
  static const List<Color> parked = [Color(0xFFDC2626), Color(0xFFF87171)];
  static const List<Color> totalAlerts = [Color(0xFFF59E0B), Color(0xFFFBBF24)];

  static const Color bottomNavActive = Color(0xFF2563EB);
  static const Color bottomNavInactive = Color(0xFF9CA3AF);

    // Fallback icon color for alert types not in the known visuals map.
  static const Color totalAlertsIconFallback = Color(0xFF9CA3AF);
}

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.bottomNavActive,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.inter().fontFamily,
    );

    return base.copyWith(
      textTheme: GoogleFonts.interTextTheme(base.textTheme).copyWith(
        headlineSmall: GoogleFonts.inter(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        foregroundColor: AppColors.textPrimary,
      ),
      cardTheme: CardThemeData(
        color: AppColors.cardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
