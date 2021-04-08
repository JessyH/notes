

import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String formatDMYHMS() => DateFormat('dd/MM/yyyy hh:mm:ss').format(this);
  String formatMDYatHM() => DateFormat("MMM dd ''yy 'at' hh:mm").format(this);
}