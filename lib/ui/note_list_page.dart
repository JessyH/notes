import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/app_strings.dart';
import 'note_list_item.dart';
import 'provider/note_list_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';

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
        title: Text(AppStrings.title),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () => {},
          ),
        ],
      ),
      drawer: Drawer(),
      body: StateAwareWidget(
        state: _noteListProvider.state,
        successWidget: _listView,
        failureWidget: _failureWidget,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.article_outlined),
        onPressed: () => {},
      ),
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

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');
}
