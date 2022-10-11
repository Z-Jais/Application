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
    final Anime anime = ModalRoute.of(context)!.settings.arguments as Anime;
    _animeEpisodeMapper.anime = anime;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(anime.name),
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
