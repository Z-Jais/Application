import 'package:flutter/material.dart';
import 'package:jais/widgets/decoration/text_border_decoration.dart';

class DayWidget extends StatefulWidget {
  final String day;
  final int dayNumber;
  final bool isSelected;

  const DayWidget({
    required this.day,
    this.dayNumber = 0,
    this.isSelected = false,
    super.key,
  });

  DayWidget copyWith({
    String? day,
    int? dayNumber,
    required bool isSelected,
  }) {
    return DayWidget(
      day: day ?? this.day,
      dayNumber: dayNumber ?? this.dayNumber,
      isSelected: isSelected,
    );
  }

  @override
  State<StatefulWidget> createState() => _DayWidgetState();
}

class _DayWidgetState extends State<DayWidget> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHover = true),
      onExit: (_) => setState(() => _isHover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: (_isHover && !widget.isSelected)
            ? Matrix4.translationValues(0, -4, 0)
            : null,
        child: TextBorderDecoration(
          text: widget.day,
          isSelected: widget.isSelected,
        ),
      ),
    );
  }
}
