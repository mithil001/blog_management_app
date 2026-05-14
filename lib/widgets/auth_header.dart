import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';

class AuthHeader extends StatelessWidget {
  final bool isRegister;

  const AuthHeader({
    super.key,
    required this.isRegister,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: AuthWaveClipper(),
      child: Container(
        height: context.responsiveHeight(260),
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryGradient,
        ),
        child: Stack(
          children: [
            if (isRegister)
              Positioned(
                top: context.responsiveHeight(48),
                left: context.responsiveWidth(16),
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: AppColors.white,
                    size: context.responsiveFont(18),
                  ),
                ),
              ),
            Positioned(
              top: context.responsiveHeight(72),
              left: 0,
              right: 0,
              child: Icon(
                isRegister
                    ? Icons.person_add_alt_1_rounded
                    : Icons.edit_note_rounded,
                color: AppColors.white,
                size: context.responsiveFont(105),
              ),
            ),
            Positioned(
              top: context.responsiveHeight(92),
              right: context.responsiveWidth(50),
              child: Container(
                height: context.responsiveWidth(58),
                width: context.responsiveWidth(58),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.14),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isRegister ? Icons.add_rounded : Icons.edit_rounded,
                  color: AppColors.white,
                  size: context.responsiveFont(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    path.lineTo(0, size.height * 0.82);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.98,
      size.width * 0.50,
      size.height * 0.86,
    );

    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.74,
      size.width,
      size.height * 0.87,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(AuthWaveClipper oldClipper) {
    return false;
  }
}