import 'dart:developer';

class Logger {
  static void info(
    Type runtimeType,
    String message, {
    String name = "info",
  }) {
    log(
      'In $runtimeType ,Time: \n${DateTime.now()}, Info : $message',
    );
  }

  static void error(
    Type runtimeType,
    String message, {
    Object? error,
    String name = "error",
  }) {
    log(
      'In $runtimeType ,Time: \n${DateTime.now()}, Error : $message , Details: \n $error',
      name: name,
    );
  }
}
