import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../extensions/datetime_ext.dart';
import '../res/app_colors.dart';
import '../res/app_strings.dart';
import 'provider/note_provider.dart';
import 'view_model/modal_bottom_sheet_view_model.dart';

class ModalBottomSheet extends StatefulWidget {
  final int id;

  ModalBottomSheet({required this.id});

  @override
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ModalBottomSheetViewModel(
        noteProvider: context.read<NoteProvider>(),
        id: widget.id,
      ),
      child: Consumer<ModalBottomSheetViewModel>(
        builder: (context, viewModel, child) {
          return _containerBody(viewModel);
        },
      ),
    );
  }

  Widget _containerBody(ModalBottomSheetViewModel viewModel) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
            decoration: _borderBottom(),
            child: Row(
              children: [
                Text(
                  viewModel.note.title,
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
                  iconColor: viewModel.note.pinned
                      ? AppColors.primary
                      : AppColors.primaryText,
                  label: viewModel.note.pinned
                      ? AppStrings.pinned
                      : AppStrings.pin,
                  onTap: () => viewModel.pinNote(),
                ),
                _expandedIconButton(
                  iconData: Icons.delete_outlined,
                  iconColor: AppColors.delete,
                  label: AppStrings.delete,
                  onTap: () => {
                    viewModel.deleteNote(),
                    Navigator.pop(context),
                  },
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
                  value: viewModel.note.words.toString(),
                ),
                _rowLabelValue(
                  label: AppStrings.characters,
                  value: viewModel.note.characters.toString(),
                ),
                _rowLabelValue(
                  label: AppStrings.created,
                  value: viewModel.note.creationDate.formatMDYatHM(),
                ),
                _rowLabelValue(
                  label: AppStrings.lastModified,
                  value: viewModel.note.modificationDate.formatMDYatHM(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
