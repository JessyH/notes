import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';
import '../model/note.dart';

class NotePage extends StatefulWidget {
  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Note _note;
  late NoteProvider _noteProvider;

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
    _note = _noteProvider.note;

    return Center(
      child: Text(_note.title),
    );
  }

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');
}
