import 'package:flutter/material.dart';
import 'package:jais/components/anime_classifier.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/simulcasts/simulcast_list.dart';
import 'package:jais/components/simulcasts/simulcast_widget.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/animes/anime_mapper.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/mappers/simulcast_mapper.dart';
import 'package:jais/utils/utils.dart';

class AnimesRecommendationView extends StatefulWidget {
  const AnimesRecommendationView({super.key});

  @override
  State<AnimesRecommendationView> createState() =>
      _AnimesRecommendationViewState();
}

class _AnimesRecommendationViewState extends State<AnimesRecommendationView> {
  final SimulcastMapper _simulcastMapper = SimulcastMapper(listener: false);
  final AnimeMapper _animeMapper = AnimeMapper(clickable: false);

  Future<void> init() async {
    await _simulcastMapper.reset();
    final Widget lastItem = _simulcastMapper.list.last;

    if (lastItem is SimulcastWidget) {
      await _simulcastMapper.scrollController.scrollToEnd(this);
      final Simulcast simulcast = lastItem.simulcast;
      _animeMapper.simulcast = simulcast;
      await _animeMapper.reset();

      if (!mounted) {
        return;
      }

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => init());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommandations'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Information'),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const <Widget>[
                        Text(
                          'Les recommandations sont basées sur les animes que vous avez marqué comme "aimé" ou "détesté".',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Plus vous marquez d\'animes, plus les recommandations seront précises.',
                        ),
                        Text(
                          'Afin d\'obtenir de meilleures recommandations, il est préférable de marquer autant d\'animes "aimés" que "détestés".',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Le système de recommandation est basé sur un algorithme de machine learning.',
                        ),
                        Text(
                          'Il est donc possible que les recommandations ne soient pas toujours pertinentes.',
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Vos données ne sont pas stockées sur nos serveurs. Elles sont uniquement utilisées pour générer les recommandations.',
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.build_circle),
            onPressed: () async {
              final int lovedSize =
                  await DeviceMapper.recommendedAnimeData.count(true);
              final int hatedSize =
                  await DeviceMapper.recommendedAnimeData.count(false);

              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Confirmez-vous la demande de recommandations ?',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        'Cette action peut prendre plusieurs minutes.\nVous pouvez continuer à utiliser l\'application pendant ce temps.',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(height: 10),
                      ListTile(
                        leading:
                            const Icon(Icons.favorite, color: Colors.green),
                        title: Text('$lovedSize animes aimés'),
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.heart_broken, color: Colors.red),
                        title: Text('$hatedSize animes détestés'),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Annuler'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                      child: const Text('Confirmer'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: init,
        child: SingleChildScrollView(
          controller: _animeMapper.scrollController,
          child: Column(
            children: <Widget>[
              InfiniteScroll<SimulcastMapper>(
                mapper: _simulcastMapper,
                builder: () => SimulcastList(
                  scrollController: _simulcastMapper.scrollController,
                  children: <Widget>[
                    ..._simulcastMapper
                        .toWidgetsSelected(_animeMapper.simulcast)
                        .map(
                          (Widget e) => e is SimulcastWidget
                              ? GestureDetector(
                                  onTap: () async {
                                    _animeMapper.scrollController.jumpTo(0);
                                    _animeMapper.simulcast = e.simulcast;
                                    await _animeMapper.reset();
                                    setState(() {});
                                  },
                                  child: e,
                                )
                              : e,
                        ),
                  ],
                ),
              ),
              InfiniteScroll<AnimeMapper>(
                mapper: _animeMapper,
                builder: () => AnimeList(
                  children: <Widget>[
                    ..._animeMapper.list.map(
                      (Widget e) {
                        if (e is! AnimeWidget) {
                          return e;
                        }

                        return AnimeClassifier(animeWidget: e);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
