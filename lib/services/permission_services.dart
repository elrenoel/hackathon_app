import 'package:flutter/services.dart';

class PermissionService {
  static const MethodChannel _channel = MethodChannel('permission_channel');

  /// 🔍 cek status semua permission
  static Future<Map<String, bool>> check() async {
    final result = await _channel.invokeMethod<Map>('checkPermissions');

    return Map<String, bool>.from(result ?? {});
  }

  /// buka Usage Access settings
  static Future<void> openUsageAccess() =>
      _channel.invokeMethod('openUsageAccess');

  /// buka Accessibility settings
  static Future<void> openAccessibility() =>
      _channel.invokeMethod('openAccessibility');

  /// buka Notification Access settings
  static Future<void> openNotification() =>
      _channel.invokeMethod('openNotification');
}
