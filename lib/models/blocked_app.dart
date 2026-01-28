import 'dart:typed_data';

class BlockedApp {
  final String name;
  final String packageName;
  final Uint8List icon;
  bool isSelected;

  BlockedApp({
    required this.name,
    required this.packageName,
    required this.icon,
    this.isSelected = false,
  });
}
