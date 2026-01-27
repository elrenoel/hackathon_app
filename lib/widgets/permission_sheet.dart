import 'package:flutter/material.dart';
import 'package:hackathon_app/services/permission_services.dart';

class PermissionSheet extends StatelessWidget {
  final Map<String, bool> status;

  const PermissionSheet({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enable permissions',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ListTile(
            title: const Text('Usage Access'),
            trailing: ElevatedButton(
              onPressed: PermissionService.openUsageAccess,
              child: const Text('Open Settings'),
            ),
          ),

          ListTile(
            title: const Text('Accessibility'),
            trailing: ElevatedButton(
              onPressed: PermissionService.openAccessibility,
              child: const Text('Open Settings'),
            ),
          ),

          ListTile(
            title: const Text('Notification Access'),
            trailing: ElevatedButton(
              onPressed: PermissionService.openNotification,
              child: const Text('Open Settings'),
            ),
          ),
        ],
      ),
    );
  }
}
