import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../res/app_colors.dart';
import 'provider/note_provider.dart';
import 'view_model/note_page_view_model.dart';

class NotePage extends StatefulWidget {
  final int? id;

  NotePage({int? id}) : this.id = id;

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NotePageViewModel(
        noteProvider: context.read<NoteProvider>(),
        id: widget.id,
      ),
      child: Consumer<NotePageViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: viewModel.note.pinned
                      ? Icon(Icons.push_pin_outlined, color: AppColors.primary)
                      : Icon(Icons.push_pin_outlined),
                  onPressed: () => viewModel.pinNote(),
                ),
                IconButton(
                  icon: Icon(Icons.save_outlined),
                  onPressed: () => viewModel.saveNote(),
                )
              ],
            ),
            body: _body(viewModel),
          );
        },
      ),
    );
  }

  Widget _body(NotePageViewModel viewModel) {
    return Container(
      child: Column(
        children: [
          TextField(
            controller: viewModel.titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '.e.g Groceries',
            ),
          ),
          TextField(
            controller: viewModel.bodyController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '- Bread - Apples',
            ),
          ),
        ],
      ),
    );
  }
}

class NotePageArguments {
  final int? id;
  NotePageArguments({int? id}) : this.id = id;
}
