import 'package:flutter/material.dart';
import 'package:jais/controllers/animes/anime_detail_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/animes/anime_image.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:jais/widgets/watchlist_button.dart';
import 'package:provider/provider.dart';

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.controller.anime!.name),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChangeNotifierProvider.value(
                value: widget.controller,
                child: Consumer<AnimeDetailController>(
                  builder: (context, value, child) {
                    return HVList(
                      hChild: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child:
                            AnimePresentation(anime: widget.controller.anime!),
                      ),
                      vController: widget.controller.scrollController,
                      vList: widget.controller.list,
                    );
                  },
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
            child: AnimeDescription(anime: anime),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: WatchlistButton(anime: anime),
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
              Text(
                anime.description ?? '',
                style: const TextStyle(
                  fontSize: 14,
                ),
                maxLines: 7,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 30),
              WatchlistButton(anime: anime),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class AnimeDescription extends StatefulWidget {
  final Anime anime;

  const AnimeDescription({
    super.key,
    required this.anime,
  });

  @override
  State<StatefulWidget> createState() => _AnimeDescriptionState();
}

class _AnimeDescriptionState extends State<AnimeDescription> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
      },
      child: Text(
        widget.anime.description ?? '',
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
        ),
        maxLines: _isOpen ? null : 5,
        overflow: _isOpen ? null : TextOverflow.ellipsis,
      ),
    );
  }
}
