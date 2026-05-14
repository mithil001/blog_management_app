import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/blog_model.dart';
import '../utils/app_constants.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const BlogCard({
    super.key,
    required this.blog,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('MMM dd, yyyy').format(blog.createdAt);

    return Container(
      margin: EdgeInsets.only(
        bottom: context.responsiveHeight(16),
      ),
      padding: EdgeInsets.all(
        context.responsiveWidth(14),
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
            height: context.responsiveHeight(105),
            width: context.responsiveWidth(90),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.medium),
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withOpacity(0.18),
                  AppColors.secondary.withOpacity(0.08),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Icon(
              Icons.article_rounded,
              color: AppColors.primary,
              size: context.responsiveFont(38),
            ),
          ),
          SizedBox(width: context.responsiveWidth(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
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
                    fontSize: context.responsiveFont(13),
                    color: AppColors.lightText,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: context.responsiveHeight(12)),
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
                        '${blog.author} • $formattedDate',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.small.copyWith(
                          fontSize: context.responsiveFont(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: context.responsiveWidth(6)),
          Column(
            children: [
              _CardActionButton(
                icon: Icons.edit_rounded,
                iconColor: AppColors.primary,
                backgroundColor: AppColors.primary.withOpacity(0.10),
                onTap: onEdit,
              ),
              SizedBox(height: context.responsiveHeight(10)),
              _CardActionButton(
                icon: Icons.delete_rounded,
                iconColor: AppColors.error,
                backgroundColor: AppColors.error.withOpacity(0.10),
                onTap: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardActionButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _CardActionButton({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.extraLarge),
      child: Container(
        padding: EdgeInsets.all(
          context.responsiveWidth(7),
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: context.responsiveFont(18),
        ),
      ),
    );
  }
}