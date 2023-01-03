import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/widgets/episodes/lite_episode_list.dart';
import 'package:jais/widgets/watchlist_button.dart';

class AnimeDetailView extends StatefulWidget {
  final AnimeDetailController controller;

  const AnimeDetailView({required this.controller, super.key});

  @override
  State<AnimeDetailView> createState() => _AnimeDetailViewState();
}

class _AnimeDetailViewState extends State<AnimeDetailView> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    widget.controller.anime ??=
        ModalRoute.of(context)!.settings.arguments! as Anime;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(widget.controller.anime?.name ?? ''),
          actions: <Widget>[
            WatchlistButton(
              onToggle: (bool inWatchlist) async {
                if (inWatchlist) {
                  await AppController.watchlist
                      .remove(widget.controller.anime!.uuid);
                } else {
                  await AppController.watchlist
                      .add(widget.controller.anime!.uuid);
                }
              },
              inWatchlist:
                  AppController.watchlist.hasIn(widget.controller.anime!.uuid),
            ),
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () {
                setState(() {
                  _isOpen = !_isOpen;
                });
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(_isOpen ? 100 : 0),
            child: _isOpen
                ? SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: SingleChildScrollView(
                        child: Text(widget.controller.anime?.description ?? ''),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(child: LiteEpisodeList(controller: widget.controller))
          ],
        ),
      ),
    );
  }
}
