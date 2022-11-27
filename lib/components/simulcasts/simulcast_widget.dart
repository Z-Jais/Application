import 'package:flutter/material.dart';
import 'package:jais/components/text_border.dart';
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
    return TextBorder(
      text: '${Dictionary.getNaturalSeason(simulcast)} ${simulcast.year}',
      isSelected: isSelected,
    );
  }
}
