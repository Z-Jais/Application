import 'package:flutter/material.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/widgets/decoration/text_border_decoration.dart';

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
    return TextBorderDecoration(
      text: '${getNaturalSeason()} ${simulcast.year}',
      isSelected: isSelected,
    );
  }
}
