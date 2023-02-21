import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/widgets/episodes/episode_list.dart';

class EpisodeTab extends StatelessWidget {
  final EpisodeController controller;

  const EpisodeTab({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: controller.load(),
      builder: (context, snapshot) {
        return EpisodeList(controller: controller);
      },
    );
  }
}
