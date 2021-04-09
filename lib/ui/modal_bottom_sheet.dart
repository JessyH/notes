import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';
import '../extensions/datetime_ext.dart';
import '../model/note.dart';
import '../res/app_colors.dart';
import '../res/app_strings.dart';

class ModalBottomSheet extends StatefulWidget {
  final int id;

  ModalBottomSheet({required this.id});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  late Note _note;
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

    return StateAwareWidget(
      state: _noteProvider.state,
      successWidget: _containerBody,
      failureWidget: _failureWidget,
    );
  }

  Widget _containerBody() {
    _note = _noteProvider.note;

    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            decoration: _borderBottom(),
            child: Row(
              children: [
                Text(
                  _note.title,
                  style: Theme.of(context).primaryTextTheme.headline6,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            decoration: _borderBottom(),
            child: Row(
              children: [
                _expandedIconButton(
                  iconData: Icons.push_pin_outlined,
                  iconColor: _note.pinned
                      ? AppColors.primary
                      : AppColors.primaryText,
                  label: _note.pinned
                      ? AppStrings.pinned
                      : AppStrings.pin,
                  onTap: () => _pinNote(),
                ),
                _expandedIconButton(
                  iconData: Icons.delete_outlined,
                  iconColor: AppColors.delete,
                  label: AppStrings.delete,
                  onTap: () => _deleteNote(),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                _rowLabelValue(
                  label: AppStrings.words,
                  value: _note.words.toString(),
                ),
                _rowLabelValue(
                  label: AppStrings.characters,
                  value: _note.characters.toString(),
                ),
                _rowLabelValue(
                  label: AppStrings.created,
                  value: _note.creationDate.formatMDYatHM(),
                ),
                _rowLabelValue(
                  label: AppStrings.lastModified,
                  value: _note.modificationDate.formatMDYatHM(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _pinNote() {}

  void _deleteNote() {}

  Widget _failureWidget() => FailureWidget(failureReason: 'Oops!');

  Widget _expandedIconButton({
    required IconData iconData,
    required String label,
    required Function onTap,
    Color iconColor = AppColors.primaryText,
  }) {
    return Expanded(
      child: InkWell(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 15),
            Icon(
              iconData,
              color: iconColor,
              size: 24,
            ),
            SizedBox(height: 5),
            Text(
              label.toUpperCase(),
              style: TextStyle(color: AppColors.primaryText, fontSize: 12),
            ),
            SizedBox(height: 15),
          ],
        ),
        onTap: () => onTap(),
      ),
    );
  }

  Widget _rowLabelValue({
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).primaryTextTheme.bodyText2,
          ),
          Text(
            value,
            style: Theme.of(context).primaryTextTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  BoxDecoration _borderBottom() {
    return BoxDecoration(
      border: Border(
        bottom: BorderSide(color: AppColors.border),
      ),
    );
  }
}
