import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'data/note_repository_impl.dart';
import 'repository/note_repository.dart';
import 'res/app_colors.dart';
import 'res/app_strings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NoteRepository>(create: (_) => NoteRepositoryImpl()),
      ],
      child: MaterialApp(
        title: AppStrings.title,
        theme: _lightTheme(),
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: AppRouter.homeRoute,
      ),
    );
  }

  ThemeData _lightTheme() {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.secondaryText),
          centerTitle: true,
          actionsIconTheme: IconThemeData(
            color: AppColors.secondaryText,
          )),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        elevation: 2,
      ),
      primaryTextTheme: TextTheme(
        headline6: TextStyle(color: AppColors.primaryText),
      ),
    );
  }
}
