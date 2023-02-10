import 'package:flutter/material.dart';

class TextBorderDecoration extends StatefulWidget {
  final String text;
  final bool isSelected;

  const TextBorderDecoration({
    required this.text,
    this.isSelected = false,
    super.key,
  });

  TextBorderDecoration copyWith({
    bool? isSelected,
  }) =>
      TextBorderDecoration(
        isSelected: isSelected ?? this.isSelected,
        text: text,
      );

  @override
  State<StatefulWidget> createState() => _TextBorderDecorationState();
}

class _TextBorderDecorationState extends State<TextBorderDecoration> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHover = true),
        onExit: (_) => setState(() => _isHover = false),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(8),
            color: widget.isSelected
                ? Theme.of(context).primaryColor
                : _isHover
                    ? Theme.of(context).primaryColor.withOpacity(0.2)
                    : Colors.transparent,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: widget.isSelected ? FontWeight.bold : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
