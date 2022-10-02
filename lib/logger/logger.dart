import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:jais/logger/log_type.dart';
import 'package:stack_trace/stack_trace.dart';

class Logger {
  static final Logger _instance = Logger();
  final DateFormat _dateFormat = DateFormat('HH:mm:ss.SSSS dd/MM/yyyy');

  void log({required LogType logType, required String message}) {
    final Frame frame = Trace.current().frames[2];
    final String format =
        '[${_dateFormat.format(DateTime.now())} ${logType.name.toUpperCase()}\t${frame.member}] $message';

    if (kDebugMode) {
      dev.log(format);
    }
  }

  static void info(String message) =>
      _instance.log(logType: LogType.info, message: message);

  static void debug(String message) =>
      _instance.log(logType: LogType.debug, message: message);

  static void warning(String message) =>
      _instance.log(logType: LogType.warning, message: message);

  static void error(
    String message, [
    Object? exception,
    StackTrace? stackTrace,
  ]) =>
      _instance.log(
        logType: LogType.error,
        message: '$message${exception.nextLine()}${stackTrace.nextLine()}',
      );
}

extension _QString on Object? {
  String nextLine() => this == null ? '' : '\n${toString()}';
}
