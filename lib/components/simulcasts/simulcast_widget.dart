import 'package:flutter/material.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/utils/dictionary.dart';

class SimulcastWidget extends StatelessWidget {
  final Simulcast simulcast;
  final bool isSelected;

  const SimulcastWidget({
    required this.simulcast,
    this.isSelected = false,
    super.key,
  });

  // Copy function
  SimulcastWidget copyWith({
    Simulcast? simulcast,
    bool? isSelected,
  }) =>
      SimulcastWidget(
        simulcast: simulcast ?? this.simulcast,
        isSelected: isSelected ?? this.isSelected,
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
            '${Dictionary.getNaturalSeason(simulcast)} ${simulcast.year}',
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
