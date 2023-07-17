import 'package:flutter/material.dart';
import 'package:jais/controllers/episodes/episode_watchlist_filter_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class EpisodeWatchlistTab extends StatefulWidget {
  const EpisodeWatchlistTab({super.key});

  @override
  State<StatefulWidget> createState() => _EpisodeWatchlistTabState();
}

class _EpisodeWatchlistTabState extends State<EpisodeWatchlistTab> {
  final _controller = EpisodeWatchlistFilterController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('EpisodeWatchlistTab', 'build()');
    return RefreshIndicator(
      child: ChangeNotifierProvider.value(
        value: _controller,
        child: Consumer<EpisodeWatchlistFilterController>(
          builder: (_, value, __) {
            if (value.nothingToShow()) {
              return const NoElement(
                title: 'Mince !',
                message:
                    'Aucun anime dans votre watchlist !\nAjoutez-en pour voir les épisodes à regarder.',
              );
            }

            return HVList(
              vController: _controller.scrollController,
              vList: _controller.list,
            );
          },
        ),
      ),
      onRefresh: () async {
        _controller.reset();
        await _controller.load();
      },
    );
  }
}
