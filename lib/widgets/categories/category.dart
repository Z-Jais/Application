import 'package:flutter/material.dart';
import 'package:jais/utils.dart';

class Category extends StatelessWidget {
  final String label;
  final Widget? trailing;
  final List<Widget> buttons;

  const Category({
    required this.label,
    required this.buttons,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (trailing == null)
          Text(label, style: Theme.of(context).textTheme.labelMedium)
        else
          Row(
            children: [
              Text(label, style: Theme.of(context).textTheme.labelMedium),
              const Spacer(),
              trailing!,
            ],
          ),
        const SizedBox(height: 8),
        Container(
          decoration: Utils.instance.buildBoxDecoration(context),
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
