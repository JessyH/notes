import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'note_list_item.dart';
import 'provider/note_list_provider.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late NoteListProvider _noteListProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<NoteListProvider>()..fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _noteListProvider = context.watch<NoteListProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: _listView(),
    );
  }

  Widget _listView() {
    return ListView.builder(
      itemCount: _noteListProvider.notes.length,
      itemBuilder: (context, int index) => NoteListItem(
        key: ObjectKey(index),
        note: _noteListProvider.notes[index],
      ),
    );
  }
}
