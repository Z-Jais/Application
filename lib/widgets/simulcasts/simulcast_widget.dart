import 'package:flutter/material.dart';
import 'package:jais/models/simulcast.dart';

class SimulcastWidget extends StatelessWidget {
  final Simulcast simulcast;
  final bool isSelected;

  const SimulcastWidget({
    required this.simulcast,
    this.isSelected = false,
    super.key,
  });

  SimulcastWidget copyWith({
    Simulcast? simulcast,
    bool? isSelected,
  }) =>
      SimulcastWidget(
        simulcast: simulcast ?? this.simulcast,
        isSelected: isSelected ?? this.isSelected,
      );

  String getNaturalSeason() {
    if (simulcast.season == 'WINTER') {
      return 'Hivers';
    }

    if (simulcast.season == 'SPRING') {
      return 'Printemps';
    }

    if (simulcast.season == 'SUMMER') {
      return 'Été';
    }

    if (simulcast.season == 'AUTUMN') {
      return 'Automne';
    }

    return '??';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.background,
      ),
      child: Text(
        '${getNaturalSeason()} ${simulcast.year}',
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : null,
          color: isSelected ? Theme.of(context).colorScheme.background : null,
        ),
      ),
    );
  }
}
