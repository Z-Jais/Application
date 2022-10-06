import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/simulcasts/simulcast_list.dart';
import 'package:jais/components/simulcasts/simulcast_widget.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/anime_mapper.dart';
import 'package:jais/mappers/simulcast_mapper.dart';
import 'package:provider/provider.dart';

class AnimesView extends StatefulWidget {
  const AnimesView({super.key});

  @override
  AnimesViewState createState() => AnimesViewState();
}

class AnimesViewState extends State<AnimesView> {
  final SimulcastMapper _simulcastMapper = SimulcastMapper(listener: false);
  final AnimeMapper _animeMapper = AnimeMapper();

  Future<void> rebuildAnimes({bool force = false}) async {
    if (force) {
      _animeMapper.clear();
    }

    await _animeMapper.updateCurrentPage();
  }

  Future<void> scrollToEndSimulcasts() async {
    Future<dynamic>.delayed(const Duration(milliseconds: 100)).then((_) {
      if (!mounted) {
        return;
      }

      try {
        _simulcastMapper.scrollController.animateTo(
          _simulcastMapper.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (_) {}
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => init());
  }

  Future<void> init() async {
    _simulcastMapper.clear();
    _animeMapper.clear();
    await _simulcastMapper.updateCurrentPage();

    if (_simulcastMapper.list.last is SimulcastWidget) {
      scrollToEndSimulcasts();
      final Simulcast simulcast =
          (_simulcastMapper.list.last as SimulcastWidget).simulcast;
      _animeMapper.simulcast = simulcast;
      await rebuildAnimes();
    }
  }

  @override
  Widget build(BuildContext context) => RefreshIndicator(
        onRefresh: () async => init(),
        child: SingleChildScrollView(
          controller: _animeMapper.scrollController,
          child: Column(
            children: <Widget>[
              ChangeNotifierProvider<SimulcastMapper>.value(
                value: _simulcastMapper,
                child: Consumer<SimulcastMapper>(
                  builder: (
                    BuildContext context,
                    SimulcastMapper simulcastMapper,
                    _,
                  ) =>
                      SimulcastList(
                    scrollController: simulcastMapper.scrollController,
                    children: simulcastMapper
                        .toWidgetsSelected(_animeMapper.simulcast)
                        .map(
                          (Widget e) => e is SimulcastWidget
                              ? GestureDetector(
                                  onTap: () async {
                                    _animeMapper.scrollController.jumpTo(0);
                                    _animeMapper.simulcast = e.simulcast;
                                    await rebuildAnimes(force: true);
                                    setState(() {});
                                  },
                                  child: e,
                                )
                              : e,
                        )
                        .toList(),
                  ),
                ),
              ),
              ChangeNotifierProvider<AnimeMapper>.value(
                value: _animeMapper,
                child: Consumer<AnimeMapper>(
                  builder: (BuildContext context, AnimeMapper animeMapper, _) =>
                      AnimeList(
                    children: animeMapper.list
                        .map<Widget>(
                          (Widget e) => GestureDetector(
                            child: e,
                            onTap: () async => e is AnimeWidget
                                ? Navigator.pushNamed(
                                    context,
                                    '/anime',
                                    arguments: e.anime,
                                  )
                                : null,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
