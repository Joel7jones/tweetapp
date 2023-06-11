import 'package:intl/intl.dart';

extension ExtendedDateTime on DateTime {
  String get toMMMDDYYYY => DateFormat().format(this);
}
