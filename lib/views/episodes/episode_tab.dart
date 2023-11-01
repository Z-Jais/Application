import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/episodes/episode_tab_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:provider/provider.dart';

class EpisodeTab extends StatefulWidget {
  const EpisodeTab({super.key});

  @override
  State<StatefulWidget> createState() => _EpisodeTabState();
}

class _EpisodeTabState extends State<EpisodeTab> {
  final _controller = EpisodeTabController();

  @override
  void initState() {
    _controller.setup();
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('EpisodeTab', 'build()');

    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<EpisodeTabController>(
        builder: (_, value, __) {
          final bool showMissingAnimes =
              AppController.watchlist.data.isNotEmpty &&
                  _controller.missingAnimeController.list.isNotEmpty;

          return RefreshIndicator(
            onRefresh: () async {
              await _controller.init();
            },
            child: HVList(
              hTitle: showMissingAnimes
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.thingsYouMayHaveMissed1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.thingsYouMayHaveMissed2,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    )
                  : null,
              hController: showMissingAnimes
                  ? value.missingAnimeController.scrollController
                  : null,
              hList:
                  showMissingAnimes ? value.missingAnimeController.list : null,
              vController: value.episodeController.scrollController,
              vList: value.episodeController.list,
            ),
          );
        },
      ),
    );
  }
}
