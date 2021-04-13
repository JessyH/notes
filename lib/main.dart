import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'data/db/DbClient.dart';
import 'data/db/NoteDao.dart';
import 'data/note_repository_impl.dart';
import 'repository/note_repository.dart';
import 'res/app_colors.dart';
import 'res/app_strings.dart';
import 'ui/provider/note_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await DbClient().db;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NoteDao>(
          create: (_) => NoteDao(),
        ),
        Provider<NoteRepository>(
          create: (context) => NoteRepositoryImpl(
            noteDao: context.read<NoteDao>(),
          ),
        ),
        ChangeNotifierProvider<NoteProvider>(
          create: (context) => NoteProvider(
            noteRepository: context.read<NoteRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.appTitle,
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
}
