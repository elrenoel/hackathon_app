import 'package:flutter/material.dart';

Widget emotionButton({
  required String assetPath,
  required bool isSelected,
  required VoidCallback onPressed,
  double size = 32,
}) {
  return InkWell(
    onTap: onPressed,
    borderRadius: BorderRadius.circular(999),
    child: Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // ignore: deprecated_member_use
        color: isSelected ? Colors.black.withOpacity(0.2) : Colors.transparent,
      ),
      child: Image.asset(
        assetPath,
        width: size,
        height: size,
        fit: BoxFit.contain,
      ),
    ),
  );
}
