import 'package:get/get.dart';

import '../models/blog_model.dart';
import '../services/api_service.dart';
import 'auth_controller.dart';

class BlogController extends GetxController {
  final ApiService apiService = Get.find<ApiService>();
  final AuthController authController = Get.find<AuthController>();

  RxBool isLoading = false.obs;
  RxList<BlogModel> blogs = <BlogModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBlogs();
  }

  Future<void> fetchBlogs() async {
    try {
      isLoading.value = true;

      final List<BlogModel> fetchedBlogs = await apiService.fetchBlogs();

      blogs.assignAll(fetchedBlogs);
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

  Future<void> addBlog({
    required String title,
    required String content,
  }) async {
    try {
      isLoading.value = true;

      final String author = authController.currentUser.value?.name ?? 'Unknown';

      final BlogModel newBlog = await apiService.addBlog(
        title: title,
        content: content,
        author: author,
      );

      blogs.insert(0, newBlog);

      Get.back();

      Get.snackbar(
        'Success',
        'Blog posted successfully.',
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

  Future<void> updateBlog({
    required BlogModel oldBlog,
    required String title,
    required String content,
  }) async {
    try {
      isLoading.value = true;

      final BlogModel updatedBlog = await apiService.updateBlog(
        id: oldBlog.id,
        title: title,
        content: content,
        author: oldBlog.author,
        createdAt: oldBlog.createdAt,
      );

      final int index = blogs.indexWhere((blog) => blog.id == oldBlog.id);

      if (index != -1) {
        blogs[index] = updatedBlog;
      }

      Get.back();

      Get.snackbar(
        'Success',
        'Blog updated successfully.',
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

  Future<void> deleteBlog(String id) async {
    try {
      isLoading.value = true;

      await apiService.deleteBlog(id);

      blogs.removeWhere((blog) => blog.id == id);

      Get.snackbar(
        'Success',
        'Blog deleted successfully.',
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
}