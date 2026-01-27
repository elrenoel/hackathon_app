import 'package:flutter/services.dart';

const _channel = MethodChannel('focus_service');

Future<void> startFocus(Duration duration, List<String> blockedPackages) async {
  await _channel.invokeMethod('startFocus', {
    'duration': duration.inSeconds,
    'blocked': blockedPackages,
  });
}
