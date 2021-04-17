import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'data/db/DbClient.dart';
import 'data/db/NoteDao.dart';
import 'data/note_repository_impl.dart';
import 'repository/note_repository.dart';
import 'res/app_themes.dart';
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
        theme: AppThemes.light(),
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: AppRouter.homeRoute,
      ),
    );
  }
}
