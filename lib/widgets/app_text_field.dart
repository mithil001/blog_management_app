import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData? icon;
  final bool obscureText;
  final int maxLines;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final TextInputType keyboardType;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.icon,
    this.obscureText = false,
    this.maxLines = 1,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
  });

  void closeKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderSide: BorderSide(
        color: AppColors.border,
        width: context.responsiveWidth(1),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.body.copyWith(
            fontSize: context.responsiveFont(14),
            fontWeight: FontWeight.w600,
            color: AppColors.darkText,
          ),
        ),
        SizedBox(height: context.responsiveHeight(8)),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType,
          onTapOutside: (event) {
            closeKeyboard();
          },
          style: AppTextStyles.body.copyWith(
            fontSize: context.responsiveFont(14),
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.body.copyWith(
              fontSize: context.responsiveFont(14),
              color: AppColors.lightText,
            ),
            prefixIcon: icon == null
                ? null
                : Icon(
              icon,
              size: context.responsiveFont(21),
              color: AppColors.lightText,
            ),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.responsiveWidth(16),
              vertical: context.responsiveHeight(18),
            ),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(
                color: AppColors.primary,
                width: context.responsiveWidth(1.4),
              ),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(
                color: AppColors.error,
                width: context.responsiveWidth(1),
              ),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(
                color: AppColors.error,
                width: context.responsiveWidth(1.4),
              ),
            ),
          ),
        ),
      ],
    );
  }
}