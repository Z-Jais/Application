import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_controller.dart';
import 'package:jais/controllers/simulcast_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class AnimeTab extends StatefulWidget {
  final SimulcastController simulcastController;
  final AnimeController animeController;

  const AnimeTab({
    required this.simulcastController,
    required this.animeController,
    super.key,
  });

  @override
  State<AnimeTab> createState() => _AnimeTabState();
}

class _AnimeTabState extends State<AnimeTab> {
  Future<void> init() async {
    final simulcastController = widget.simulcastController;
    final animeController = widget.animeController;

    simulcastController.reset();
    await simulcastController.load();

    if (simulcastController.lastPageError) {
      return;
    }

    simulcastController.scrollController.scrollToEnd(this);
    animeController.simulcast =
        (simulcastController.list.last as SimulcastWidget).simulcast;
    animeController.reset();
    animeController.load();
    simulcastController.notify();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => init());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: init,
      child: SingleChildScrollView(
        controller: widget.animeController.scrollController,
        child: Column(
          children: <Widget>[
            SimulcastList(
              simulcastController: widget.simulcastController,
              animeController: widget.animeController,
            ),
            AnimeList(
              controller: widget.animeController,
              listView: false,
            ),
          ],
        ),
      ),
    );
  }
}
