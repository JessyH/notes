import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../model/note.dart';
import '../res/app_strings.dart';
import 'note_page.dart';
import 'note_list_item.dart';
import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late Future<List<Note>> _futureNotes;

  @override
  void initState() {
    super.initState();
    _futureNotes = context.read<NoteProvider>().fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<NoteProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      drawer: Drawer(),
      body: _body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.article_outlined),
        onPressed: () => Navigator.pushNamed(
          context,
          AppRouter.noteRoute,
          arguments: NotePageArguments(),
        ),
      ),
    );
  }

  Widget _body() {
    return FutureBuilder<List<Note>>(
      future: _futureNotes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return _listView(snapshot.data!);
        } else if (snapshot.hasError) {
          return FailureWidget(failureReason: 'Oops!');
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _listView(List<Note> notes) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, int index) => NoteListItem(
        key: ObjectKey(index),
        note: notes[index],
      ),
    );
  }
}
