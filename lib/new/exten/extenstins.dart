import 'package:intl/intl.dart';

extension DateBeautify on DateTime {
  ///how to use
  ///DateTime().beautify()
  ///
  String beautify() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(this);
  }
  String aBeautify() {
    final DateFormat formatter = DateFormat.yMMMd('en_US');
    return formatter.format(this);
  }
  String get time => DateFormat.jm().format(this);
}