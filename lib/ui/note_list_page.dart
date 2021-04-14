import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_router.dart';
import '../res/app_strings.dart';
import 'note_page.dart';
import 'note_list_item.dart';
import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  late NoteProvider _noteProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      context.read<NoteProvider>().fetchNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _noteProvider = context.watch<NoteProvider>();

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
      body: StateAwareWidget(
        state: _noteProvider.state,
        successWidget: _listView,
        failureWidget: _failureWidget,
      ),
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

  Widget _listView() {
    return ListView.builder(
      itemCount: _noteProvider.notes.length,
      itemBuilder: (context, int index) => NoteListItem(
        key: ObjectKey(index),
        id: _noteProvider.notes[index].id,
      ),
    );
  }

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');
}
