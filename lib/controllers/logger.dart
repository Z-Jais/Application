import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('HH:mm:ss.SSSS dd/MM/yyyy');

enum LogLevel {
  debug('\x1B[34m'),
  info('\x1B[32m'),
  warning('\x1B[33m'),
  error('\x1B[31m'),
  ;

  final String color;

  const LogLevel(this.color);
}

void _log(LogLevel level, String member, String message) {
  if (kDebugMode) {
    final format =
        '${level.color}[${_dateFormat.format(DateTime.now())} $member] $message\x1B[0m';
    debugPrint(format);
  }
}

void info(String member, String message) {
  _log(LogLevel.info, member, message);
}

void debug(String member, String message) {
  _log(LogLevel.debug, member, message);
}

void warning(String member, String message) {
  _log(LogLevel.warning, member, message);
}

void error(
  String member,
  String message,
  Object error,
  StackTrace stackTrace,
) {
  _log(
    LogLevel.error,
    member,
    '$message\n$error\n$stackTrace',
  );
}
