import 'package:flutter/material.dart';
import 'package:hackathon_app/models/blocked_app.dart';

class BlockApp extends StatelessWidget {
  final List<BlockedApp> blockedApps;
  final VoidCallback onAddPressed;
  final ValueChanged<BlockedApp> onRemove;

  const BlockApp({
    super.key,
    required this.blockedApps,
    required this.onAddPressed,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Title Row
        Row(
          children: [
            Expanded(
              child: Text(
                'Blocked Apps',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            IconButton(onPressed: onAddPressed, icon: const Icon(Icons.add)),
          ],
        ),

        const SizedBox(height: 8),

        // 🔹 List blocked apps
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: blockedApps.map((app) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.memory(app.icon, width: 32, height: 32),
                  const SizedBox(width: 6),
                  GestureDetector(
                    onTap: () => onRemove(app),
                    child: const Icon(Icons.close, size: 14),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
