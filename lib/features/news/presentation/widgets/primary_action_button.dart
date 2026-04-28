import 'package:flutter/material.dart';

class PrimaryActionButton extends StatelessWidget {
  const PrimaryActionButton({required this.label, required this.icon, required this.onPressed, this.isEnabled = true, super.key});

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(onPressed: isEnabled ? onPressed : null, icon: Icon(icon), label: Text(label));
  }
}
