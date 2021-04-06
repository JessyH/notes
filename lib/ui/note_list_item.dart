import 'package:flutter/material.dart';

import 'note_page.dart';
import '../model/note.dart';
import '../app_router.dart';

class NoteListItem extends StatelessWidget {
  final Note note;

  NoteListItem({
    required Key key,
    required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(note.ellapsedTime),
                  // pinned icon
                ],
              ),
            ),
            Expanded(
              flex: 8,
              child: Column(
                children: [
                  Row(children: [Text(note.title)]),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.noteRoute,
        arguments: NotePageArguments(note.id),
      ),
    );

    // return ListTile(
    //   title: Text(note.title),
    //   onTap: () => Navigator.pushNamed(
    //     context,
    //     AppRouter.noteRoute,
    //     arguments: NotePageArguments(note.id),
    //   ),
    // );
  }
}
