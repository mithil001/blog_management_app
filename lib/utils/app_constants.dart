import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Blog App';

  static const String baseUrl = 'https://6a04af9caa826ca75c090ef1.mockapi.io';
}

class AppColors {
  static const Color primary = Color(0xff5B5FEF);
  static const Color secondary = Color(0xff7B61FF);
  static const Color background = Color(0xffF8F8FD);

  static const Color darkText = Color(0xff111827);
  static const Color lightText = Color(0xff6B7280);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color error = Color(0xffEF4444);
  static const Color success = Color(0xff22C55E);

  static Color border = Colors.grey.shade300;
  static Color cardShadow = Colors.black.withOpacity(0.06);
  static Color primaryShadow = primary.withOpacity(0.30);
}

class AppGradients {
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [
      AppColors.secondary,
      AppColors.primary,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppRadius {
  static const double small = 10;
  static const double medium = 14;
  static const double large = 18;
  static const double extraLarge = 24;
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 350);
}

class AppTextStyles {
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.darkText,
  );

  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.darkText,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.darkText,
  );

  static const TextStyle small = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.lightText,
  );

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  bool get isSmallPhone => screenWidth < 360;
  bool get isNormalPhone => screenWidth >= 360 && screenWidth < 600;
  bool get isTablet => screenWidth >= 600;

  double responsiveWidth(double value) {
    final baseWidth = isTablet ? 768.0 : 390.0;
    return screenWidth * (value / baseWidth);
  }

  double responsiveHeight(double value) {
    final baseHeight = isTablet ? 1024.0 : 844.0;
    return screenHeight * (value / baseHeight);
  }

  double responsiveFont(double value) {
    if (isSmallPhone) {
      return value * 0.92;
    }

    if (isTablet) {
      return value * 1.12;
    }

    return value;
  }

  EdgeInsets screenPadding() {
    if (isTablet) {
      return EdgeInsets.symmetric(
        horizontal: responsiveWidth(120),
        vertical: responsiveHeight(24),
      );
    }

    return EdgeInsets.symmetric(
      horizontal: responsiveWidth(24),
      vertical: responsiveHeight(16),
    );
  }
}