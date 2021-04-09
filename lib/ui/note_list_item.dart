import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'modal_bottom_sheet.dart';
import 'provider/note_provider.dart';
import '../app_router.dart';
import '../res/app_colors.dart';

class NoteListItem extends StatelessWidget {
  NoteListItem({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _note = context.watch<NoteProvider>().note;

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
                          _note.ellapsedTime,
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
                          _note.title,
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
                      if (_note.pinned)
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
                            _note.body,
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
      onTap: () => Navigator.pushNamed(context, AppRouter.noteRoute),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => Wrap(
        children: [
          ChangeNotifierProvider<NoteProvider>.value(
            value: context.read<NoteProvider>(),
            child: ModalBottomSheet(),
          )
        ],
      ),
    );
  }
}
