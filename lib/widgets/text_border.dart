import 'package:flutter/material.dart';

class TextBorder extends StatelessWidget {
  final String text;
  final bool isSelected;

  const TextBorder({
    required this.text,
    this.isSelected = false,
    super.key,
  });

  TextBorder copyWith({
    bool? isSelected,
  }) =>
      TextBorder(
        isSelected: isSelected ?? this.isSelected,
        text: text,
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
          color:
              isSelected ? Theme.of(context).primaryColor : Colors.transparent,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.bold : null,
            ),
          ),
        ),
      ),
    );
  }
}
