import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jais/components/lite_episodes/lite_episode_list.dart';
import 'package:jais/components/lite_episodes/lite_episode_widget.dart';
import 'package:jais/entities/anime.dart';
import 'package:jais/mappers/anime_episode_mapper.dart';
import 'package:provider/provider.dart';

class AnimeDetailView extends StatefulWidget {
  final String uuid;

  const AnimeDetailView({required this.uuid, super.key});

  @override
  State<AnimeDetailView> createState() => _AnimeDetailViewState();
}

class _AnimeDetailViewState extends State<AnimeDetailView> {
  late final AnimeEpisodeMapper _animeEpisodeMapper;
  UniqueKey _key = UniqueKey();
  Anime? _anime;

  @override
  void initState() {
    super.initState();
    _animeEpisodeMapper = AnimeEpisodeMapper(uuid: widget.uuid);
    _animeEpisodeMapper.clear();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => _animeEpisodeMapper.updateCurrentPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        key: _key,
        title: Text(_anime?.name ?? ''),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/2'),
        ),
        actions: <Widget>[
          if (_anime?.description != null &&
              _anime?.description?.isNotEmpty == true)
            IconButton(
              icon: const Icon(Icons.info_outline),
              onPressed: () async => showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
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
                    final Widget firstWidget = animeEpisodeMapper.list.first;

                    if (firstWidget is LiteEpisodeWidget && _anime == null) {
                      _anime = firstWidget.episode.anime;

                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => setState(() => _key = UniqueKey()),
                      );
                    }

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
