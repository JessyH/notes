import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_router.dart';
import 'data/note_repository_impl.dart';
import 'repository/note_repository.dart';

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
        title: 'Notes',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: (settings) => AppRouter.onGenerateRoute(settings),
        initialRoute: AppRouter.homeRoute,
      ),
    );
  }
}
