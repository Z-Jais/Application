import 'package:flutter/material.dart';
import 'package:jais/components/animes/anime_list.dart';
import 'package:jais/components/animes/anime_widget.dart';
import 'package:jais/components/infinite_scroll.dart';
import 'package:jais/components/no_element.dart';
import 'package:jais/mappers/anime_mapper.dart';
import 'package:jais/utils/utils.dart';

class AnimesWatchlistView extends StatefulWidget {
  const AnimesWatchlistView({super.key});

  @override
  State<AnimesWatchlistView> createState() => _AnimesWatchlistViewState();
}

class _AnimesWatchlistViewState extends State<AnimesWatchlistView> {
  final AnimeMapper _animeMapper = AnimeMapper(listener: false);

  @override
  void initState() {
    super.initState();
    _animeMapper.clear();

    WidgetsBinding.instance
        .addPostFrameCallback((_) async => _animeMapper.updateWatchlistPage());

    _animeMapper.scrollController.addListener(() async {
      if (_animeMapper.scrollController.position.extentAfter <= 0 &&
          !_animeMapper.isLoading &&
          _animeMapper.canLoadMore) {
        _animeMapper.isLoading = true;
        Utils.clearImagesCache();
        _animeMapper.page++;
        final bool correct = await _animeMapper.updateWatchlistPage();

        if (!correct) {
          _animeMapper.page--;
          _animeMapper.canLoadMore = true;
          _animeMapper.removeLoader();

          Future<void>.delayed(const Duration(seconds: 1)).then((_) {
            _animeMapper.isLoading = false;
          });

          return;
        }

        _animeMapper.isLoading = false;
        _animeMapper.canLoadMore =
            _animeMapper.list.length % _animeMapper.limit == 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _animeMapper.clear();
        _animeMapper.updateWatchlistPage();
      },
      child: SingleChildScrollView(
        controller: _animeMapper.scrollController,
        child: InfiniteScroll<AnimeMapper>(
          mapper: _animeMapper,
          builder: () => _animeMapper.list.whereType<AnimeWidget>().isEmpty &&
                  _animeMapper.page == 1 &&
                  _animeMapper.lastPageError
              ? const NoElement()
              : AnimeList(children: _animeMapper.list),
        ),
      ),
    );
  }
}
