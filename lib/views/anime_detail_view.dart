import 'package:flutter/material.dart';
import 'package:jais/components/lite_episodes/lite_episode_list.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/anime_episode_mapper.dart';
import 'package:provider/provider.dart';

class AnimeDetailView extends StatefulWidget {
  const AnimeDetailView({super.key});

  @override
  State<AnimeDetailView> createState() => _AnimeDetailViewState();
}

class _AnimeDetailViewState extends State<AnimeDetailView> {
  Anime? _anime;
  final AnimeEpisodeMapper _animeEpisodeMapper = AnimeEpisodeMapper();

  @override
  void initState() {
    super.initState();
    _animeEpisodeMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _animeEpisodeMapper.updateCurrentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If anime is not init
    if (_anime == null) {
      _anime = ModalRoute.of(context)!.settings.arguments as Anime;
      _animeEpisodeMapper.anime = _anime;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(_anime?.name ?? ''),
        actions: <Widget>[
          if (_anime?.description != null &&
              _anime?.description?.isNotEmpty == true)
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () async => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text(_anime?.name ?? ''),
                  content: Text(_anime?.description ?? ''),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _animeEpisodeMapper.clear();
                _animeEpisodeMapper.updateCurrentPage();
              },
              child: ChangeNotifierProvider<AnimeEpisodeMapper>.value(
                value: _animeEpisodeMapper,
                child: Consumer<AnimeEpisodeMapper>(
                  builder: (_, AnimeEpisodeMapper animeEpisodeMapper, __) {
                    return LiteEpisodeList(
                      scrollController: animeEpisodeMapper.scrollController,
                      children: animeEpisodeMapper.list,
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
