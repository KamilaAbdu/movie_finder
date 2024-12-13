import 'package:flutter/material.dart';
import 'package:movie_finder/core/constants/app_colors.dart';

class AppTextStyles {
  static const header = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColor);
  static const body = TextStyle(fontSize: 16, color: AppColors.secondaryTextColor);
  static const title = TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textColor);
  static const detail = TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.secondaryTextColor);
}