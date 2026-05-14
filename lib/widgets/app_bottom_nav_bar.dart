import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/app_constants.dart';
import '../utils/app_routes.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavBar({
    super.key,
    required this.selectedIndex,
  });

  void _handleNavigation(int index) {
    if (index == selectedIndex) {
      return;
    }

    if (index == 0) {
      Get.offNamed(AppRoutes.home);
    } else if (index == 1) {
      Get.offNamed(AppRoutes.blogs);
    } else {
      Get.snackbar(
        'Profile',
        'Profile screen is not included in this demo.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.responsiveHeight(76),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.cardShadow,
            blurRadius: context.responsiveWidth(20),
            offset: Offset(
              0,
              -context.responsiveHeight(8),
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            isSelected: selectedIndex == 0,
            onTap: () => _handleNavigation(0),
          ),
          _BottomNavItem(
            icon: Icons.article_outlined,
            label: 'Blogs',
            isSelected: selectedIndex == 1,
            onTap: () => _handleNavigation(1),
          ),
          _BottomNavItem(
            icon: Icons.person_outline_rounded,
            label: 'Profile',
            isSelected: selectedIndex == 2,
            onTap: () => _handleNavigation(2),
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = isSelected ? AppColors.primary : AppColors.lightText;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveWidth(12),
          vertical: context.responsiveHeight(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: context.responsiveFont(24),
            ),
            SizedBox(height: context.responsiveHeight(4)),
            Text(
              label,
              style: AppTextStyles.small.copyWith(
                fontSize: context.responsiveFont(12),
                color: color,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}