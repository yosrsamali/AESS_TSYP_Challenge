import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const RoundedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
