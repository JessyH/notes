import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';

class NotePage extends StatefulWidget {
  final int id;

  NotePage({required this.id});

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
      appBar: AppBar(),
      body: StateAwareWidget(
        state: _noteProvider.state,
        successWidget: _noteBody,
        failureWidget: _failureWidget,
      ),
    );
  }

  Widget _noteBody() {
    return Center(
      child: Text(_noteProvider.note.title),
    );
  }

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');
}

class NotePageArguments {
  final int id;
  NotePageArguments(this.id);
}
