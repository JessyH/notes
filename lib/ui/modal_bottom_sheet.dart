import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/note_provider.dart';
import 'shared/failure_widget.dart';
import 'shared/state_aware_widget.dart';
import '../extensions/datetime_ext.dart';
import '../res/app_colors.dart';
import '../res/app_strings.dart';

class ModalBottomSheet extends StatefulWidget {
  final int id;

  ModalBottomSheet({required this.id});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
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
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 5),
            decoration: _borderBottom(),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 28,
                        color: AppColors.secondaryText,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _noteProvider.note.title,
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
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
                  iconColor: _noteProvider.note.pinned
                      ? AppColors.primary
                      : AppColors.primaryText,
                  label: _noteProvider.note.pinned
                      ? AppStrings.pinned
                      : AppStrings.pin,
                  onTap: () => {},
                ),
                _expandedIconButton(
                  iconData: Icons.delete_outlined,
                  label: AppStrings.delete,
                  onTap: () => {},
                ),
              ],
            ),
          ),
          Column(
            children: [
              _rowLabelValue(
                label: AppStrings.words,
                value: _noteProvider.note.words.toString(),
              ),
              _rowLabelValue(
                label: AppStrings.characters,
                value: _noteProvider.note.characters.toString(),
              ),
              _rowLabelValue(
                label: AppStrings.created,
                value: _noteProvider.note.creationDate.formatMDYatHM(),
              ),
              _rowLabelValue(
                label: AppStrings.lastModified,
                value: _noteProvider.note.modificationDate.formatMDYatHM(),
              ),
            ],
          ),
        ],
      ),
    );
  }

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
            ),
            SizedBox(height: 5),
            Text(
              label.toUpperCase(),
              style: Theme.of(context).primaryTextTheme.bodyText2,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(context).primaryTextTheme.bodyText1,
        ),
        Text(
          value,
          style: Theme.of(context).primaryTextTheme.bodyText2,
        ),
      ],
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
