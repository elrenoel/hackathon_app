import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget emotionButton({
  required String text,
  required Color color,
  required bool isSelected,
  required VoidCallback onPressed,
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (isSelected) {
          return color; // warna selected
        }
        // ignore: deprecated_member_use
        return color.withOpacity(0.35); // normal
      }),
      // ignore: deprecated_member_use
      overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
      foregroundColor: WidgetStateProperty.all(Colors.black),
      shape: WidgetStateProperty.all(const StadiumBorder()),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
      elevation: WidgetStateProperty.all(0),
    ),
    child: Text(
      text,
      style: GoogleFonts.instrumentSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
