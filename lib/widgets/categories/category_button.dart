import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final Widget icon;
  final Widget? trailing;
  final VoidCallback onTap;

  const CategoryButton({
    required this.label,
    required this.icon,
    this.trailing,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: icon,
            ),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: trailing,
              ),
          ],
        ),
      ),
    );
  }
}
