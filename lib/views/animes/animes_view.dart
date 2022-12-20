import 'package:flutter/material.dart';
import 'package:jais/mappers/animes/anime_mapper.dart';
import 'package:jais/mappers/simulcast_mapper.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/utils/utils.dart';
import 'package:jais/widgets/animes/anime_list.dart';
import 'package:jais/widgets/infinite_scroll.dart';
import 'package:jais/widgets/simulcasts/simulcast_list.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class AnimesView extends StatefulWidget {
  const AnimesView({super.key});

  @override
  State<AnimesView> createState() => _AnimesViewState();
}

class _AnimesViewState extends State<AnimesView> {
  final SimulcastMapper _simulcastMapper = SimulcastMapper(listener: false);
  final AnimeMapper _animeMapper = AnimeMapper();

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
    return RefreshIndicator(
      onRefresh: init,
      child: SingleChildScrollView(
        controller: _animeMapper.scrollController,
        child: Column(
          children: <Widget>[
            InfiniteScroll<SimulcastMapper>(
              controller: _simulcastMapper,
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
              controller: _animeMapper,
              builder: () =>
                  AnimeList(children: <Widget>[..._animeMapper.list]),
            ),
          ],
        ),
      ),
    );
  }
}
