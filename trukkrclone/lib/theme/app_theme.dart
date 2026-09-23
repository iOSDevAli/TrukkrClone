import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Central place for every color / gradient used across the Trukkr app.
/// Keeping these as named constants means new screens automatically
/// stay visually consistent with the Dashboard.
/// Palette: "Highway / Logistics" identity — asphalt charcoal, route
/// amber, and signal colors drawn from road signage and fleet livery,
/// rather than a generic SaaS blue/purple dashboard palette.
class AppColors {
  AppColors._();

  // static const Color background = Color(0xFFF3F4F6);
  static const Color background = Color(0xFFF5F4F1); // Fog — warm concrete grey
  static const Color cardBackground = Colors.white;
  //static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textPrimary = Color(0xFF1C1F26); // Asphalt
  static const Color textSecondary = Color(0xFF6B7280);

  static const Color brandPrimary = Color(0xFFFF6A13); // Route Amber
  static const Color brandSecondary = Color(0xFFFFC93C); // Highway Yellow

  // Vehicle status indicator colors
  // static const Color running = Color(0xFF22C55E);
  // static const Color stopped = Color(0xFFEF4444);
  // static const Color idle = Color(0xFFFACC15);
  // static const Color offline = Color(0xFF3B82F6);
  static const Color running = Color(0xFF1E9E64); // Signal Green
  static const Color stopped = Color(0xFFE5484D); // Alert Red
  static const Color idle = Color(0xFFFFC93C); // Highway Yellow
  static const Color offline = Color(0xFF5B7083); // Steel
  static const Color noData = Color(0xFF9CA3AF);
  // static const Color expired = Color(0xFF7F1D1D);
  static const Color expired = Color(0xFF7A2626); // Maroon

  // Alert / menu card gradients (top-left -> bottom-right)
  // static const List<Color> geofence = [Color(0xFF7B2FF7), Color(0xFF9B4DFF)];
  // static const List<Color> overspeed = [Color(0xFF7B2FF7), Color(0xFFB06CFF)];
  // static const List<Color> excessIdle = [Color(0xFF3B82F6), Color(0xFF60A5FA)];
  // static const List<Color> excessDriving = [Color(0xFF2563EB), Color(0xFF60A5FA)];
  // static const List<Color> ignition = [Color(0xFFEF4444), Color(0xFFF87171)];
  // static const List<Color> parked = [Color(0xFFDC2626), Color(0xFFF87171)];
  // static const List<Color> totalAlerts = [Color(0xFFF59E0B), Color(0xFFFBBF24)];
  static const List<Color> geofence = [Color(0xFF0F7A72), Color(0xFF17A398)]; // Route Teal
  static const List<Color> overspeed = [Color(0xFFE5484D), Color(0xFFFF7A61)]; // Alert Red -> coral
  static const List<Color> excessIdle = [Color(0xFF5B7083), Color(0xFF8A9BAB)]; // Steel
  static const List<Color> excessDriving = [Color(0xFF1E9E64), Color(0xFF3DBE84)]; // Signal Green
  static const List<Color> ignition = [Color(0xFF1C1F26), Color(0xFF3A3F4B)]; // Asphalt
  static const List<Color> parked = [Color(0xFF7A2626), Color(0xFFAA4444)]; // Maroon
  static const List<Color> totalAlerts = [Color(0xFFFF6A13), Color(0xFFFFC93C)]; // Route Amber -> Highway Yellow

  // static const Color bottomNavActive = Color(0xFF2563EB);
  static const Color bottomNavActive = Color(0xFFFF6A13); // Route Amber
  static const Color bottomNavInactive = Color(0xFF9CA3AF);

  // Used only by the redesigned Dashboard's bottom nav + header, which
  // follow a separate navy/blue reference design rather than the
  // Highway palette above — kept distinct so other screens (which still
  // reference bottomNavActive/brandPrimary) are unaffected.
  static const Color navActiveBlue = Color(0xFF2563EB);
  static const Color headerNavyDark = Color(0xFF16233F);
  static const Color headerNavyLight = Color(0xFF2E4770);

  // Fallback icon color for alert types not in the known visuals map.
  static const Color totalAlertsIconFallback = Color(0xFF9CA3AF);

  // Icon accent colors used across menu tiles / settings rows, so each
  // category reads consistently everywhere it appears.
  static const Color iconReports = Color(0xFF0F7A72); // Route Teal
  static const Color iconHistory = Color(0xFF1E9E64); // Signal Green
  static const Color iconVehicles = Color(0xFF1C1F26); // Asphalt
  static const Color iconFuel = Color(0xFFFF6A13); // Route Amber
  static const Color iconMoney = Color(0xFFB8860B); // Amber-gold
  static const Color iconMaintenance = Color(0xFF7A2626); // Maroon
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
