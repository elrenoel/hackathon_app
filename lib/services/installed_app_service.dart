import 'package:flutter/services.dart';

class InstalledAppService {
  static const MethodChannel _channel = MethodChannel('installed_apps');

  static Future<List<dynamic>> getInstalledApps() async {
    final result = await _channel.invokeMethod('getInstalledApps');
    return result;
  }
}
