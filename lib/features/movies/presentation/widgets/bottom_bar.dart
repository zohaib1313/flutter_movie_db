import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_booking_app/core/theme/app_colors.dart';

class FigmaStyledBottomNavBar extends StatelessWidget {
  const FigmaStyledBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.h,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [BoxShadow(blurRadius: 16.r, offset: Offset(0, -4.h))],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _navItem(
              icon: Icons.dashboard,
              label: "Dashboard",
              isSelected: false,
            ),
            _navItem(icon: Icons.movie, label: "Watch", isSelected: true),
            _navItem(icon: Icons.folder_copy, label: "Media Library"),
            _navItem(icon: Icons.format_list_bulleted_rounded, label: "More"),
          ],
        ),
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    bool isSelected = false,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 24.h,
          color: isSelected ? AppColors.light : Colors.grey,
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.h,
            color: isSelected ? AppColors.light : Colors.grey,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
