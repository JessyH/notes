import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';
import '../model/note.dart';

class NotePage extends StatefulWidget {
  final int? id;

  NotePage({int? id}) : this.id = id;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  late Note _note;
  late NoteProvider _noteProvider;
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _titleController.addListener(() {
      print('Title: ${_titleController.text}');
    });
  }

  @override
  Widget build(BuildContext context) {
    _noteProvider = context.watch<NoteProvider>();
    _note =
        (widget.id != null) ? _noteProvider.getNote(widget.id!) : Note.empty();

    return Scaffold(
      appBar: AppBar(),
      body: _body(),
    );
  }

  Widget _body() {
    if (widget.id != null) {
      return StateAwareWidget(
        state: _noteProvider.state,
        successWidget: _noteBody,
        failureWidget: _failureWidget,
      );
    } else {
      return _noteBody();
    }
  }

  Widget _noteBody() {
    _titleController.text = _note.title;
    _bodyController.text = _note.body;

    return Container(
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '.e.g Groceries',
            ),
          ),
          TextField(
            controller: _bodyController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '- Bread - Apples',
            ),
          ),
        ],
      ),
    );
  }

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}

class NotePageArguments {
  final int? id;
  NotePageArguments({int? id}) : this.id = id;
}
