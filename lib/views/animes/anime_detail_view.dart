import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:jais/widgets/infinite_scroll.dart';
import 'package:jais/widgets/watchlist_button.dart';

class AnimeDetailView extends StatefulWidget {
  final AnimeDetailController controller;

  const AnimeDetailView({required this.controller, super.key});

  @override
  State<AnimeDetailView> createState() => _AnimeDetailViewState();
}

class _AnimeDetailViewState extends State<AnimeDetailView> {
  @override
  Widget build(BuildContext context) {
    widget.controller.anime ??=
        ModalRoute.of(context)!.settings.arguments! as Anime;

    return Scaffold(
      backgroundColor: context.mainBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              child: InfiniteScroll(
                controller: widget.controller,
                builder: () => HVList(
                  hChild: AnimePresentation(anime: widget.controller.anime!),
                  vController: widget.controller.scrollController,
                  vList: widget.controller.list,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimePresentation extends StatelessWidget {
  final Anime anime;

  const AnimePresentation({
    super.key,
    required this.anime,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isOnMobile) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              BackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Row(
            children: [
              const Spacer(),
              AnimeImage(
                anime: anime,
                width: 200,
                height: 300,
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              anime.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              anime.description ?? '',
              style: const TextStyle(
                fontSize: 14,
              ),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: WatchlistButton(
              onToggle: (bool inWatchlist) async {
                if (inWatchlist) {
                  await AppController.watchlist.remove(anime.uuid);
                } else {
                  await AppController.watchlist.add(anime.uuid);
                }
              },
              inWatchlist: AppController.watchlist.hasIn(anime.uuid),
            ),
          ),
        ],
      );
    }

    return Row(
      children: [
        const Spacer(),
        AnimeImage(
          anime: anime,
          width: 200,
          height: 300,
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BackButton(
                onPressed: () => Navigator.of(context).pop(),
              ),
              const SizedBox(height: 20),
              Text(
                anime.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                anime.description ?? '',
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 30),
              WatchlistButton(
                onToggle: (bool inWatchlist) async {
                  if (inWatchlist) {
                    await AppController.watchlist.remove(anime.uuid);
                  } else {
                    await AppController.watchlist.add(anime.uuid);
                  }
                },
                inWatchlist: AppController.watchlist.hasIn(anime.uuid),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
