import 'package:flutter/material.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/utils/dictionary.dart';
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

  @override
  Widget build(BuildContext context) {
    return TextBorderDecoration(
      text:
          '${Dictionary.instance.getNaturalSeason(simulcast)} ${simulcast.year}',
      isSelected: isSelected,
    );
  }
}
