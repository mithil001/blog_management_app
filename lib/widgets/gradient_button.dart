import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

class GradientButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = context.responsiveHeight(56);
    final double iconSize = context.responsiveFont(20);
    final double loaderSize = context.responsiveWidth(22);

    return Opacity(
      opacity: onPressed == null || isLoading ? 0.75 : 1,
      child: Container(
        height: buttonHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradients.primaryGradient,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryShadow,
              blurRadius: context.responsiveWidth(18),
              offset: Offset(
                0,
                context.responsiveHeight(8),
              ),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.medium),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppRadius.medium),
            onTap: isLoading ? null : onPressed,
            child: Center(
              child: isLoading
                  ? SizedBox(
                height: loaderSize,
                width: loaderSize,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      color: AppColors.white,
                      size: iconSize,
                    ),
                    SizedBox(width: context.responsiveWidth(10)),
                  ],
                  Text(
                    text,
                    style: AppTextStyles.button.copyWith(
                      fontSize: context.responsiveFont(16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}