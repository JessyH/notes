import 'package:flutter/material.dart';

import 'ui/note_list_page.dart';
import 'ui/note_page.dart';

class AppRouter {
  static const String homeRoute = '/';
  static const String noteRoute = '/note';

  static MaterialPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => NoteListPage());
      case noteRoute:
        final args = settings.arguments as NotePageArguments;
        return MaterialPageRoute(builder: (_) => NotePage(id: args.id));
    }
  }
}
