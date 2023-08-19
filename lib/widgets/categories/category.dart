import 'package:flutter/material.dart';
import 'package:jais/utils.dart';

class Category extends StatelessWidget {
  final String label;
  final List<Widget> buttons;

  const Category({required this.label, required this.buttons, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(4, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...buttons.joinWidget(
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    height: 1,
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
