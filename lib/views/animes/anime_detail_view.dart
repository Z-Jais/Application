import 'package:flutter/material.dart';
import 'package:jais/components/episodes/lite_episode_list.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/animes/anime_episode_mapper.dart';
import 'package:jais/mappers/device_mapper.dart';

class AnimeDetailView extends StatefulWidget {
  const AnimeDetailView({super.key});

  @override
  State<AnimeDetailView> createState() => _AnimeDetailViewState();
}

class _AnimeDetailViewState extends State<AnimeDetailView> {
  final AnimeEpisodeMapper _animeEpisodeMapper = AnimeEpisodeMapper();
  Anime? _anime;
  bool _isOpen = false;
  bool _inWatchlist = false;

  @override
  void initState() {
    super.initState();
    _animeEpisodeMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        _animeEpisodeMapper.updateCurrentPage();

        if (_anime != null) {
          _inWatchlist =
              await DeviceMapper.animeWatchlistData.has(_anime!.uuid);

          if (!mounted) {
            return;
          }

          setState(() {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_anime == null) {
      _anime = ModalRoute.of(context)!.settings.arguments as Anime;
      _animeEpisodeMapper.uuid = _anime!.uuid;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_anime?.name ?? ''),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              _inWatchlist
                  ? Icons.indeterminate_check_box_outlined
                  : Icons.add_box_outlined,
              color: _inWatchlist ? Colors.red : Colors.green,
            ),
            onPressed: () async {
              if (_inWatchlist) {
                await DeviceMapper.animeWatchlistData.remove(_anime!.uuid);
              } else {
                await DeviceMapper.animeWatchlistData.add(_anime!.uuid);
              }

              setState(() {
                _inWatchlist = !_inWatchlist;
              });
            },
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
                      child: Text(_anime?.description ?? ''),
                    ),
                  ),
                )
              : const SizedBox(),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _animeEpisodeMapper.reset(),
              child: InfiniteScroll<AnimeEpisodeMapper>(
                mapper: _animeEpisodeMapper,
                builder: () => LiteEpisodeList(
                  scrollController: _animeEpisodeMapper.scrollController,
                  children: <Widget>[..._animeEpisodeMapper.list],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
