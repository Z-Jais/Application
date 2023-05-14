import 'package:flutter/material.dart';

class BorderDecoration extends StatefulWidget {
  final Widget child;
  final bool hoverListener;

  const BorderDecoration({
    required this.child,
    this.hoverListener = false,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _BorderDecorationState();
}

class _BorderDecorationState extends State<BorderDecoration> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) {
          if (widget.hoverListener) {
            setState(() => _isHover = true);
          }
        },
        onExit: (_) {
          if (widget.hoverListener) {
            setState(() => _isHover = false);
          }
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: _isHover
                ? Theme.of(context).primaryColor.withOpacity(0.2)
                : Theme.of(context).colorScheme.background,
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
