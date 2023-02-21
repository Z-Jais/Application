import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/episodes/episode_list.dart';

class EpisodeTab extends StatefulWidget {
  const EpisodeTab({super.key});

  @override
  State<StatefulWidget> createState() => _EpisodeTabState();
}

class _EpisodeTabState extends State<EpisodeTab> {
  final _controller = EpisodeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('EpisodeTab', 'build()');
    return EpisodeList(controller: _controller);
  }
}
