import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final String label;
  final Widget? icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool subCategory;

  const CategoryButton({
    required this.label,
    this.icon,
    this.trailing,
    this.onTap,
    this.subCategory = false,
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
            if (icon != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: icon,
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
              ),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: subCategory ? FontWeight.bold : FontWeight.normal,
                ),
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
