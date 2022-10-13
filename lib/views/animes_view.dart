import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
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
      _animeMapper.updateCurrentPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: init,
      child: SingleChildScrollView(
        controller: _animeMapper.scrollController,
        child: Column(
          children: <Widget>[
            ChangeNotifierProvider<SimulcastMapper>.value(
              value: _simulcastMapper,
              child: Consumer<SimulcastMapper>(
                builder: (_, SimulcastMapper simulcastMapper, __) {
                  return SimulcastList(
                    scrollController: simulcastMapper.scrollController,
                    children: simulcastMapper
                        .toWidgetsSelected(_animeMapper.simulcast)
                        .map(
                          (Widget e) => e is SimulcastWidget
                              ? GestureDetector(
                                  onTap: () async {
                                    _animeMapper.scrollController.jumpTo(0);
                                    _animeMapper.simulcast = e.simulcast;
                                    _animeMapper.clear();
                                    await _animeMapper.updateCurrentPage();
                                    setState(() {});
                                  },
                                  child: e,
                                )
                              : e,
                        ),
                  );
                },
              ),
            ),
            ChangeNotifierProvider<AnimeMapper>.value(
              value: _animeMapper,
              child: Consumer<AnimeMapper>(
                builder: (_, AnimeMapper animeMapper, __) {
                  return AnimeList(children: animeMapper.list);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
