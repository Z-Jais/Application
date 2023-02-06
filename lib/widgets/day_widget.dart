import 'package:flutter/material.dart';
import 'package:jais/widgets/decoration/text_border_decoration.dart';

class DayWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: TextBorderDecoration(text: day, isSelected: isSelected),
    );
  }
}
