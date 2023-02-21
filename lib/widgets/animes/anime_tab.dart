import 'package:flutter/material.dart';
import 'package:jais/controllers/anime_tab_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_list.dart';

class AnimeTab extends StatefulWidget {
  const AnimeTab({super.key});

  @override
  State<StatefulWidget> createState() => _AnimeTabState();
}

class _AnimeTabState extends State<AnimeTab> {
  final _controller = AnimeTabController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('AnimeTab', 'build()');
    return SingleChildScrollView(
      controller: _controller.animeController.scrollController,
      child: Column(
        children: <Widget>[
          SimulcastList(
            simulcastController: _controller.simulcastController,
            animeController: _controller.animeController,
          ),
          AnimeList(
            controller: _controller.animeController,
            listView: false,
          ),
        ],
      ),
    );
  }
}
