import 'dart:convert';
import 'package:hackathon_app/models/blocked_app.dart';
import 'package:hackathon_app/services/installed_app_service.dart';

Future<List<BlockedApp>> loadInstalledApps() async {
  final rawApps = await InstalledAppService.getInstalledApps();

  return rawApps.map<BlockedApp>((app) {
    return BlockedApp(
      name: app['name'],
      packageName: app['packageName'],
      icon: base64Decode(app['icon']),
    );
  }).toList();
}
