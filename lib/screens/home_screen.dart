import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/blog_controller.dart';
import '../models/blog_model.dart';
import '../utils/app_constants.dart';
import '../utils/app_routes.dart';
import '../widgets/app_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogController blogController = Get.find<BlogController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: const AppBottomNavBar(
        selectedIndex: 0,
      ),
      body: SafeArea(
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

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: blogController.fetchBlogs,
              child: ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(
                  context.responsiveWidth(20),
                  context.responsiveHeight(14),
                  context.responsiveWidth(20),
                  context.responsiveHeight(100),
                ),
                itemCount: blogController.blogs.isEmpty
                    ? 2
                    : blogController.blogs.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _HomeHeader(
                      authController: authController,
                      blogController: blogController,
                    );
                  }

                  if (blogController.blogs.isEmpty) {
                    return const _EmptyHomeBlogs();
                  }

                  final BlogModel blog = blogController.blogs[index - 1];

                  return _HomeBlogCard(
                    blog: blog,
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.blogDetail,
                        arguments: blog,
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  final AuthController authController;
  final BlogController blogController;

  const _HomeHeader({
    required this.authController,
    required this.blogController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                Get.snackbar(
                  'Menu',
                  'Menu is not included in this demo.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              icon: Icon(
                Icons.menu_rounded,
                size: context.responsiveFont(26),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  'Home',
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
                size: context.responsiveFont(25),
              ),
            ),
            IconButton(
              onPressed: authController.logout,
              icon: Icon(
                Icons.logout_rounded,
                size: context.responsiveFont(24),
              ),
            ),
          ],
        ),
        SizedBox(height: context.responsiveHeight(18)),
        Text(
          'Hello, ${authController.userName}',
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: context.responsiveFont(22),
          ),
        ),
        SizedBox(height: context.responsiveHeight(4)),
        Text(
          'Explore the latest blogs',
          style: AppTextStyles.body.copyWith(
            fontSize: context.responsiveFont(14),
            color: AppColors.lightText,
          ),
        ),
        SizedBox(height: context.responsiveHeight(20)),
      ],
    );
  }
}

class _HomeBlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback onTap;

  const _HomeBlogCard({
    required this.blog,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: Container(
        margin: EdgeInsets.only(
          bottom: context.responsiveHeight(16),
        ),
        padding: EdgeInsets.all(
          context.responsiveWidth(16),
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppRadius.large),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: context.responsiveWidth(16),
              offset: Offset(
                0,
                context.responsiveHeight(8),
              ),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: context.responsiveHeight(90),
              width: context.responsiveWidth(78),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.medium),
                color: AppColors.primary.withOpacity(0.10),
              ),
              child: Icon(
                Icons.article_rounded,
                color: AppColors.primary,
                size: context.responsiveFont(36),
              ),
            ),
            SizedBox(width: context.responsiveWidth(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.title.isEmpty ? 'Untitled Blog' : blog.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.title.copyWith(
                      fontSize: context.responsiveFont(16),
                    ),
                  ),
                  SizedBox(height: context.responsiveHeight(6)),
                  Text(
                    blog.content,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.lightText,
                      fontSize: context.responsiveFont(13),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: context.responsiveHeight(10)),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: context.responsiveWidth(13),
                        backgroundColor: AppColors.primary.withOpacity(0.12),
                        child: Text(
                          blog.author.isNotEmpty
                              ? blog.author[0].toUpperCase()
                              : 'A',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: context.responsiveFont(11),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: context.responsiveWidth(7)),
                      Expanded(
                        child: Text(
                          blog.author,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.small.copyWith(
                            color: AppColors.primary,
                            fontSize: context.responsiveFont(12),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: context.responsiveWidth(6)),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.lightText,
              size: context.responsiveFont(15),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyHomeBlogs extends StatelessWidget {
  const _EmptyHomeBlogs();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.responsiveHeight(100),
      ),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.article_outlined,
              color: AppColors.lightText,
              size: context.responsiveFont(56),
            ),
            SizedBox(height: context.responsiveHeight(12)),
            Text(
              'No blogs available',
              style: AppTextStyles.title.copyWith(
                fontSize: context.responsiveFont(18),
              ),
            ),
            SizedBox(height: context.responsiveHeight(6)),
            Text(
              'Go to Blogs page to add a new blog.',
              textAlign: TextAlign.center,
              style: AppTextStyles.body.copyWith(
                fontSize: context.responsiveFont(14),
                color: AppColors.lightText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}