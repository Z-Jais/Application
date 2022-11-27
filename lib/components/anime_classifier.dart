import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_loader_widget.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/device_mapper.dart';

class AnimeClassifier extends StatefulWidget {
  final AnimeWidget animeWidget;

  const AnimeClassifier({required this.animeWidget, super.key});

  @override
  State<AnimeClassifier> createState() => _AnimeClassifierState();
}

class _AnimeClassifierState extends State<AnimeClassifier> {
  final Future<Map<String, dynamic>> _future =
      DeviceMapper.recommendedAnimeData.load();

  @override
  Widget build(BuildContext context) {
    final Anime anime = widget.animeWidget.anime;
    final String uuid = anime.uuid;

    return FutureBuilder<Map<String, dynamic>>(
      future: _future,
      builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const AnimeLoaderWidget();
        }

        final Map<String, dynamic> data = snapshot.data!;

        return Stack(
          children: <Widget>[
            widget.animeWidget,
            Positioned(
              top: -5,
              left: -5,
              child: IconButton(
                icon: RoundBorderWidget(
                  radius: 360,
                  widget: ColoredBox(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.heart_broken,
                        color: data[uuid] == false ? Colors.red : null,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (data[uuid] == false) {
                    data[uuid] = null;
                    await DeviceMapper.recommendedAnimeData.remove(uuid);
                  } else {
                    data[uuid] = false;
                    await DeviceMapper.recommendedAnimeData.add(uuid, false);
                  }

                  setState(() {});
                },
              ),
            ),
            Positioned(
              top: -5,
              right: -5,
              child: IconButton(
                icon: RoundBorderWidget(
                  radius: 360,
                  widget: ColoredBox(
                    color: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(
                        Icons.favorite,
                        color: data[uuid] == true ? Colors.green : null,
                      ),
                    ),
                  ),
                ),
                onPressed: () async {
                  if (data[uuid] == true) {
                    data[uuid] = null;
                    await DeviceMapper.recommendedAnimeData.remove(uuid);
                  } else {
                    data[uuid] = true;
                    await DeviceMapper.recommendedAnimeData.add(uuid, true);
                  }

                  setState(() {});
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
