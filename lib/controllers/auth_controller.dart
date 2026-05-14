import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/api_service.dart';
import '../utils/app_routes.dart';

class AuthController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();

  RxBool isLoading = false.obs;
  Rxn<UserModel> currentUser = Rxn<UserModel>();

  bool get isLoggedIn => currentUser.value != null;

  String get userName {
    return currentUser.value?.name ?? 'User';
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final UserModel? user = await apiService.login(
        email: email,
        password: password,
      );

      if (user == null) {
        Get.snackbar(
          'Login Failed',
          'Invalid email or password.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      currentUser.value = user;

      Get.offAllNamed(AppRoutes.home);

      Get.snackbar(
        'Success',
        'Login successful.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Error',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await apiService.register(
        name: name,
        email: email,
        password: password,
      );

      Get.offAllNamed(AppRoutes.login);

      Get.snackbar(
        'Success',
        'Registration successful. Please login.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (error) {
      Get.snackbar(
        'Registration Failed',
        error.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void logout() {
    currentUser.value = null;

    Get.offAllNamed(AppRoutes.login);

    Get.snackbar(
      'Logout',
      'You have been logged out.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}