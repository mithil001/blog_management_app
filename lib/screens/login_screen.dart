import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_header.dart';
import '../widgets/gradient_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = true;
  bool hidePassword = true;

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

  void submitLogin() {
    if (formKey.currentState!.validate()) {
      authController.login(
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              const AuthHeader(isRegister: false),
              Padding(
                padding: context.screenPadding(),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(height: context.responsiveHeight(4)),
                      Text(
                        'Welcome Back!',
                        style: AppTextStyles.headingLarge.copyWith(
                          fontSize: context.responsiveFont(26),
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(8)),
                      Text(
                        'Login to continue your journey',
                        style: AppTextStyles.body.copyWith(
                          fontSize: context.responsiveFont(14),
                          color: AppColors.lightText,
                        ),
                      ),
                      SizedBox(height: context.responsiveHeight(32)),

                      AppTextField(
                        controller: emailController,
                        label: 'Email',
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),

                      SizedBox(height: context.responsiveHeight(16)),

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

                      SizedBox(height: context.responsiveHeight(10)),

                      Row(
                        children: [
                          SizedBox(
                            height: context.responsiveHeight(34),
                            width: context.responsiveWidth(34),
                            child: Checkbox(
                              value: rememberMe,
                              activeColor: AppColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppRadius.small,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  rememberMe = value ?? true;
                                });
                              },
                            ),
                          ),
                          SizedBox(width: context.responsiveWidth(8)),
                          Text(
                            'Remember me',
                            style: AppTextStyles.body.copyWith(
                              fontSize: context.responsiveFont(13),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              Get.snackbar(
                                'Forgot Password',
                                'This feature is not included in this demo.',
                                snackPosition: SnackPosition.BOTTOM,
                              );
                            },
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.body.copyWith(
                                fontSize: context.responsiveFont(13),
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.responsiveHeight(14)),

                      Obx(
                            () => GradientButton(
                          text: 'Login',
                          isLoading: authController.isLoading.value,
                          onPressed: submitLogin,
                        ),
                      ),

                      SizedBox(height: context.responsiveHeight(24)),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: AppColors.border,
                              thickness: context.responsiveHeight(1),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.responsiveWidth(12),
                            ),
                            child: Text(
                              'or',
                              style: AppTextStyles.small.copyWith(
                                fontSize: context.responsiveFont(13),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: AppColors.border,
                              thickness: context.responsiveHeight(1),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: context.responsiveHeight(18)),

                      Container(
                        height: context.responsiveHeight(54),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextButton.icon(
                          onPressed: () {
                            Get.snackbar(
                              'Google Login',
                              'This feature is not included in this demo.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          },
                          icon: Icon(
                            Icons.g_mobiledata_rounded,
                            size: context.responsiveFont(32),
                            color: AppColors.darkText,
                          ),
                          label: Text(
                            'Continue with Google',
                            style: AppTextStyles.body.copyWith(
                              fontSize: context.responsiveFont(14),
                              color: AppColors.darkText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: context.responsiveHeight(24)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: AppTextStyles.body.copyWith(
                              fontSize: context.responsiveFont(14),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.toNamed(AppRoutes.register),
                            child: Text(
                              'Register',
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