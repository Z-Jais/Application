import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/mappers/anime_mapper.dart';
import 'package:provider/provider.dart';

class AnimeSearchView extends StatefulWidget {
  const AnimeSearchView({super.key});

  @override
  State<AnimeSearchView> createState() => _AnimeSearchViewState();
}

class _AnimeSearchViewState extends State<AnimeSearchView> {
  final AnimeMapper _animeMapper = AnimeMapper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Rechercher un anime',
            border: InputBorder.none,
          ),
          autofocus: true,
          onSubmitted: (String value) async {
            await _animeMapper.search(value);
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: ChangeNotifierProvider<AnimeMapper>.value(
                value: _animeMapper,
                child: Consumer<AnimeMapper>(
                  builder: (_, AnimeMapper animeMapper, __) {
                    return AnimeList(children: animeMapper.list);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
