import 'package:flutter/material.dart';
import 'package:hackathon_app/services/permission_services.dart';

class PermissionSheet extends StatefulWidget {
  final Map<String, bool> status;

  const PermissionSheet({super.key, required this.status});

  @override
  State<PermissionSheet> createState() => _PermissionSheetState();
}

class _PermissionSheetState extends State<PermissionSheet>
    with WidgetsBindingObserver {
  late Map<String, bool> _status;

  @override
  void initState() {
    super.initState();
    _status = Map.from(widget.status);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _refresh();
    }
  }

  Future<void> _refresh() async {
    final newStatus = await PermissionService.check();
    if (!mounted) return;
    setState(() => _status = newStatus);
  }

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
          const SizedBox(height: 16),

          _item(
            title: 'Accessibility',
            enabled: _status['accessibility'] ?? false,
            onOpen: () async {
              PermissionService.openAccessibility();
              await Future.delayed(const Duration(milliseconds: 500));
              await _refresh();
            },
          ),

          _item(
            title: 'Notification Access',
            enabled: _status['notification'] ?? false,
            onOpen: () async {
              PermissionService.openNotification();
              await Future.delayed(const Duration(milliseconds: 500));
              await _refresh();
            },
          ),

          _item(
            title: 'Usage Access',
            enabled: _status['usage'] ?? false,
            onOpen: () async {
              PermissionService.openUsageAccess();
              await Future.delayed(const Duration(milliseconds: 500));
              await _refresh();
            },
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _status.values.every((e) => e)
                  ? () => Navigator.pop(context)
                  : null,
              child: const Text('All permissions enabled'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _item({
    required String title,
    required bool enabled,
    required VoidCallback onOpen,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        enabled ? Icons.check_circle : Icons.cancel,
        color: enabled ? Colors.green : Colors.red,
      ),
      title: Text(title),
      subtitle: Text(
        enabled ? 'Enabled' : 'Not enabled',
        style: TextStyle(
          color: enabled ? Colors.green : Colors.red,
          fontSize: 12,
        ),
      ),
      trailing: enabled
          ? null
          : TextButton(onPressed: onOpen, child: const Text('Open Settings')),
    );
  }
}
