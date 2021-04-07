

import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String displayFormat() => DateFormat('dd/MM/yyyy hh:mm:ss').format(this);
}