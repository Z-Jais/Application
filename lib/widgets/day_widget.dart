import 'package:flutter/material.dart';
import 'package:jais/utils.dart';

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
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.all(Radius.circular(Const.defaultRadius)),
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.background,
      ),
      child: Text(
        day,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? Theme.of(context).colorScheme.background : null,
        ),
      ),
    );
  }
}
