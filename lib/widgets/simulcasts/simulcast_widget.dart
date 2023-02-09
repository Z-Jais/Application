import 'package:flutter/material.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/widgets/decoration/text_border_decoration.dart';

class SimulcastWidget extends StatefulWidget {
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
  State<StatefulWidget> createState() => _SimulcastWidgetState();
}

class _SimulcastWidgetState extends State<SimulcastWidget> {
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
          text: '${widget.getNaturalSeason()} ${widget.simulcast.year}',
          isSelected: widget.isSelected,
        ),
      ),
    );
  }
}
