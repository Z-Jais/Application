import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/simulcasts/simulcast_list.dart';
import 'package:jais/components/simulcasts/simulcast_widget.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/anime_mapper.dart';
import 'package:jais/mappers/simulcast_mapper.dart';
import 'package:jais/utils/utils.dart';

class AnimesView extends StatefulWidget {
  const AnimesView({super.key});

  @override
  State<AnimesView> createState() => _AnimesViewState();
}

class _AnimesViewState extends State<AnimesView> {
  final SimulcastMapper _simulcastMapper = SimulcastMapper(listener: false);
  final AnimeMapper _animeMapper = AnimeMapper();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async => init());
  }

  Future<void> init() async {
    _simulcastMapper.clear();
    _animeMapper.clear();
    await _simulcastMapper.updateCurrentPage();

    final Widget lastItem = _simulcastMapper.list.last;

    if (lastItem is SimulcastWidget) {
      await _simulcastMapper.scrollController.scrollToEnd(this);
      final Simulcast simulcast = lastItem.simulcast;
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
            InfiniteScroll<SimulcastMapper>(
              mapper: _simulcastMapper,
              child: SimulcastList(
                scrollController: _simulcastMapper.scrollController,
                children: _simulcastMapper
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
              ),
            ),
            InfiniteScroll<AnimeMapper>(
              mapper: _animeMapper,
              child: AnimeList(children: _animeMapper.list),
            ),
          ],
        ),
      ),
    );
  }
}
