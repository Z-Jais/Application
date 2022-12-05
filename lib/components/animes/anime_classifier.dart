import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/device_mapper.dart';

class AnimeClassifier extends StatefulWidget {
  final AnimeWidget animeWidget;
  late final Anime anime;

  AnimeClassifier({required this.animeWidget, super.key}) {
    anime = animeWidget.anime;
  }

  @override
  State<AnimeClassifier> createState() => _AnimeClassifierState();
}

class _AnimeClassifierState extends State<AnimeClassifier> {
  bool? get _value =>
      DeviceMapper.instance.recommendedAnimeData.data[widget.anime.uuid]
          as bool?;

  @override
  Widget build(BuildContext context) {
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
                    color: _value == false ? Colors.red : null,
                  ),
                ),
              ),
            ),
            onPressed: () async {
              if (_value == false) {
                await DeviceMapper.instance.recommendedAnimeData
                    .remove(widget.anime.uuid);
              } else {
                await DeviceMapper.instance.recommendedAnimeData
                    .add(widget.anime.uuid, false);
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
                    color: _value == true ? Colors.green : null,
                  ),
                ),
              ),
            ),
            onPressed: () async {
              if (_value == true) {
                await DeviceMapper.instance.recommendedAnimeData
                    .remove(widget.anime.uuid);
              } else {
                await DeviceMapper.instance.recommendedAnimeData
                    .add(widget.anime.uuid, true);
              }

              setState(() {});
            },
          ),
        ),
      ],
    );
  }
}
