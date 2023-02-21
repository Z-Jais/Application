import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('HH:mm:ss.SSSS dd/MM/yyyy');

void log(
  String member,
  String message, {
  Object? error,
  StackTrace? stackTrace,
}) {
  final format =
      '[${_dateFormat.format(DateTime.now())} $member] $message ${error != null ? '\n$error' : ''} ${stackTrace != null ? '\n$stackTrace' : ''}';
  debugPrint(format);
}
