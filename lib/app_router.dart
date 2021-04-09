import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'repository/note_repository.dart';
import 'ui/note_list_page.dart';
import 'ui/note_page.dart';
import 'ui/provider/note_list_provider.dart';
import 'ui/provider/note_provider.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String noteRoute = '/note';

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider<NoteListProvider>(
            create: (context) => NoteListProvider(
              noteRepository: context.read<NoteRepository>(),
            ),
            child: NoteListPage(),
          ),
        );
      case noteRoute:
        return MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider<NoteProvider>.value(
            value: context.read<NoteProvider>(),
            child: NotePage(),
          ),
        );
    }
  }
}
