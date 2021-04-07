import 'package:flutter/material.dart';

import 'note_page.dart';
import '../app_router.dart';
import '../extensions/datetime_ext.dart';
import '../model/note.dart';
import '../res/app_colors.dart';

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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Text(
                          note.ellapsedTime,
                          style: Theme.of(context).primaryTextTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          note.title,
                          style: Theme.of(context).primaryTextTheme.subtitle1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      if (note.pinned)
                        Icon(
                          Icons.push_pin_outlined,
                          color: AppColors.primary,
                          size: 16,
                        ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: AppColors.border),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 16),
                          child: Text(
                            note.body,
                            style: Theme.of(context).primaryTextTheme.bodyText2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      onLongPress: () => _showModalBottomSheet(context),
      onTap: () => Navigator.pushNamed(
        context,
        AppRouter.noteRoute,
        arguments: NotePageArguments(note.id),
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [Icon(Icons.article_outlined)],
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        note.title,
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(note.creationDate.displayFormat()),
                      Text(
                        'created',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),
                      Text(note.modificationDate.displayFormat()),
                      Text(
                        'last modified',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('${note.words}'),
                      Text(
                        'words',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('${note.characters}'),
                      Text(
                        'characters',
                        style: Theme.of(context).primaryTextTheme.bodyText2,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.push_pin_outlined),
                        Text('pin'),
                      ],
                    ),
                    onTap: () => {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Column(
                      children: [
                        Icon(Icons.delete_outlined),
                        Text('delete'),
                      ],
                    ),
                    onTap: () => {},
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
