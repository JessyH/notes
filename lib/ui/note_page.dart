import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';

class NotePage extends StatefulWidget {
  final int id;
  final String title;

  NotePage({required this.id, required this.title});

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late NoteProvider _noteProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<NoteProvider>()..fetchNote(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    _noteProvider = context.watch<NoteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: null,
    );
  }
}

class NotePageArguments {
  final int id;
  final String title;
  NotePageArguments(this.id, this.title);
}
