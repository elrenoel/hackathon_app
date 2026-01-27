import 'package:flutter/services.dart';

class FocusService {
  static const MethodChannel _channel = MethodChannel('focus_service');

  /// start focus session (native)
  static Future<void> startFocus(List<String> blockedApps) async {
    await _channel.invokeMethod('startFocus', {'blocked': blockedApps});
  }

  /// stop focus session (native)
  static Future<void> stopFocus() async {
    await _channel.invokeMethod('stopFocus');
  }
}
