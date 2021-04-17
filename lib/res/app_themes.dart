import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppThemes {
  static ThemeData light() => ThemeData.light().copyWith(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.secondaryText),
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: AppColors.secondaryText,
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: AppColors.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          elevation: 2,
        ),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: AppColors.primaryText),
          subtitle1: TextStyle(color: AppColors.primaryText),
          bodyText1: TextStyle(color: AppColors.primaryText),
          bodyText2: TextStyle(color: AppColors.secondaryText),
        ),
      );
}
