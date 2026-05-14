import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/gradient_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool hidePassword = true;
  bool hideConfirmPassword = true;

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!GetUtils.isEmail(value.trim())) {
      return 'Enter a valid email address';
    }

    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Password is required';
    }

    if (value.trim().length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Confirm password is required';
    }

    if (value.trim() != passwordController.text.trim()) {
      return 'Passwords do not match';
    }

    return null;
  }

  void submitRegister() {
    if (formKey.currentState!.validate()) {
      authController.register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AuthHeader(isRegister: true),
              Padding(
                padding: context.screenPadding(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: context.responsiveHeight(4)),
                      Text(
                        'Create Account',
                        style: AppTextStyles.headingLarge.copyWith(
                          fontSize: context.responsiveFont(26),
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(8)),
                      Text(
                        'Sign up to get started',
                        style: AppTextStyles.body.copyWith(
                          fontSize: context.responsiveFont(14),
                          color: AppColors.lightText,
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(28)),

                      AppTextField(
                        controller: nameController,
                        label: 'Name',
                        hint: 'Enter your full name',
                        icon: Icons.person_outline_rounded,
                        keyboardType: TextInputType.name,
                        validator: validateName,
                      ),

                      SizedBox(height: context.responsiveHeight(14)),

                      AppTextField(
                        controller: emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),

                      SizedBox(height: context.responsiveHeight(14)),

                      AppTextField(
                        controller: passwordController,
                        label: 'Password',
                        hint: 'Enter your password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: hidePassword,
                        validator: validatePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                          icon: Icon(
                            hidePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.lightText,
                            size: context.responsiveFont(21),
                          ),
                        ),
                      ),

                      SizedBox(height: context.responsiveHeight(14)),

                      AppTextField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
                        hint: 'Confirm your password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: hideConfirmPassword,
                        validator: validateConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              hideConfirmPassword = !hideConfirmPassword;
                            });
                          },
                          icon: Icon(
                            hideConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.lightText,
                            size: context.responsiveFont(21),
                          ),
                        ),
                      ),

                      SizedBox(height: context.responsiveHeight(24)),

                      Obx(
                            () => GradientButton(
                          text: 'Register',
                          isLoading: authController.isLoading.value,
                          onPressed: submitRegister,
                        ),
                      ),

                      SizedBox(height: context.responsiveHeight(24)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppTextStyles.body.copyWith(
                              fontSize: context.responsiveFont(14),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.offAllNamed(AppRoutes.login),
                            child: Text(
                              'Login',
                              style: AppTextStyles.body.copyWith(
                                fontSize: context.responsiveFont(14),
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.responsiveHeight(24)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}