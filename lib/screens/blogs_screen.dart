import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/blog_controller.dart';
import '../models/blog_model.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../widgets/app_bottom_nav_bar.dart';
import '../widgets/blog_card.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({super.key});

  void showDeleteDialog({
    required BlogController blogController,
    required BlogModel blog,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.large),
        ),
        title: const Text('Delete Blog'),
        content: const Text('Are you sure you want to delete this blog?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              blogController.deleteBlog(blog.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final BlogController blogController = Get.find<BlogController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 1,
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppGradients.primaryGradient,
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryShadow,
              blurRadius: context.responsiveWidth(16),
              offset: Offset(
                0,
                context.responsiveHeight(8),
              ),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () => Get.toNamed(AppRoutes.addBlog),
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Icon(
            Icons.add_rounded,
            color: AppColors.white,
            size: context.responsiveFont(28),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.responsiveWidth(8),
                context.responsiveHeight(8),
                context.responsiveWidth(8),
                context.responsiveHeight(4),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Get.offNamed(AppRoutes.home),
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColors.darkText,
                      size: context.responsiveFont(24),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Manage Blogs',
                        style: AppTextStyles.headingMedium.copyWith(
                          fontSize: context.responsiveFont(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: blogController.fetchBlogs,
                    icon: Icon(
                      Icons.refresh_rounded,
                      color: AppColors.darkText,
                      size: context.responsiveFont(24),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Obx(
                    () {
                  if (blogController.isLoading.value &&
                      blogController.blogs.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  if (blogController.blogs.isEmpty) {
                    return RefreshIndicator(
                      color: AppColors.primary,
                      onRefresh: blogController.fetchBlogs,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: context.screenPadding(),
                        children: [
                          SizedBox(height: context.responsiveHeight(120)),
                          Icon(
                            Icons.article_outlined,
                            color: AppColors.lightText,
                            size: context.responsiveFont(56),
                          ),
                          SizedBox(height: context.responsiveHeight(12)),
                          Text(
                            'No blogs found',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.title.copyWith(
                              fontSize: context.responsiveFont(18),
                            ),
                          ),
                          SizedBox(height: context.responsiveHeight(6)),
                          Text(
                            'Tap the plus button to add your first blog.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body.copyWith(
                              fontSize: context.responsiveFont(14),
                              color: AppColors.lightText,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return RefreshIndicator(
                    color: AppColors.primary,
                    onRefresh: blogController.fetchBlogs,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(
                        context.responsiveWidth(20),
                        context.responsiveHeight(12),
                        context.responsiveWidth(20),
                        context.responsiveHeight(100),
                      ),
                      itemCount: blogController.blogs.length,
                      itemBuilder: (context, index) {
                        final BlogModel blog = blogController.blogs[index];

                        return BlogCard(
                          blog: blog,
                          onEdit: () {
                            Get.toNamed(
                              AppRoutes.editBlog,
                              arguments: blog,
                            );
                          },
                          onDelete: () {
                            showDeleteDialog(
                              blogController: blogController,
                              blog: blog,
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}