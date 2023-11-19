import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/episodes/episode_watchlist_controller.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class ProfileEpisodesView extends StatefulWidget {
  final EpisodeWatchlistController controller;

  const ProfileEpisodesView({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _ProfileEpisodesViewState();
}

class _ProfileEpisodesViewState extends State<ProfileEpisodesView> {
  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.controller.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.episodesViewed),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChangeNotifierProvider.value(
                value: widget.controller,
                child: Consumer<EpisodeWatchlistController>(
                  builder: (context, value, child) {
                    if (value.nothingToShow()) {
                      return const NoElement(
                        title: 'Mince !',
                        message:
                            'Aucun animé dans votre watchlist !\nAjoutez-en pour voir les épisodes à regarder.',
                      );
                    }

                    return HVList(
                      vController: value.scrollController,
                      vList: value.list,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
