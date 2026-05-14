import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/blog_model.dart';
import '../utils/app_constants.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BlogModel blog = Get.arguments as BlogModel;

    final String formattedDate =
    DateFormat('MMM dd, yyyy hh:mm a').format(blog.createdAt);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Blog Details',
          style: AppTextStyles.headingMedium.copyWith(
            fontSize: context.responsiveFont(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: context.screenPadding(),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(
              context.responsiveWidth(18),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: context.responsiveHeight(110),
                    width: context.responsiveWidth(110),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(AppRadius.large),
                    ),
                    child: Icon(
                      Icons.article_rounded,
                      color: AppColors.primary,
                      size: context.responsiveFont(52),
                    ),
                  ),
                ),

                SizedBox(height: context.responsiveHeight(24)),

                Text(
                  blog.title.isEmpty ? 'Untitled Blog' : blog.title,
                  style: AppTextStyles.headingMedium.copyWith(
                    fontSize: context.responsiveFont(24),
                  ),
                ),

                SizedBox(height: context.responsiveHeight(12)),

                Row(
                  children: [
                    CircleAvatar(
                      radius: context.responsiveWidth(15),
                      backgroundColor: AppColors.primary.withOpacity(0.12),
                      child: Text(
                        blog.author.isNotEmpty
                            ? blog.author[0].toUpperCase()
                            : 'A',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: context.responsiveFont(12),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: context.responsiveWidth(8)),
                    Expanded(
                      child: Text(
                        '${blog.author} • $formattedDate',
                        style: AppTextStyles.small.copyWith(
                          fontSize: context.responsiveFont(12),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: context.responsiveHeight(20)),

                Divider(
                  color: AppColors.border,
                ),

                SizedBox(height: context.responsiveHeight(16)),

                Text(
                  blog.content,
                  style: AppTextStyles.body.copyWith(
                    fontSize: context.responsiveFont(15),
                    height: 1.6,
                    color: AppColors.darkText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}