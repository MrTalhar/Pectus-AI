import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isPrimary;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.icon,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ??
            (isPrimary
                ? Theme.of(context).primaryColor
                : Theme.of(context).cardTheme.color),
        foregroundColor: foregroundColor ??
            (isPrimary
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).primaryColor),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: Theme.of(context).dividerColor),
        ),
        elevation: 0,
        overlayColor: isPrimary 
            ? (foregroundColor?.withAlpha(20) ?? Theme.of(context).colorScheme.onPrimary.withAlpha(20))
            : (foregroundColor?.withAlpha(30) ?? Theme.of(context).primaryColor.withAlpha(30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
