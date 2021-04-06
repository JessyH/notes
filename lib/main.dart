import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/note_repository_impl.dart';
import 'repository/note_repository.dart';
import 'ui/provider/note_list_provider.dart';
import 'ui/note_list_page.dart';

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
        home: ChangeNotifierProvider<NoteListProvider>(
          create: (context) => NoteListProvider(
            noteRepository: context.read<NoteRepository>(),
          ),
          child: NoteListPage(),
        ),
      ),
    );
  }
}
