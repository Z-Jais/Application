import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/animes/anime_watchlist_controller.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:jais/widgets/no_element.dart';
import 'package:provider/provider.dart';

class ProfileAnimesView extends StatefulWidget {
  final AnimeWatchlistController controller;

  const ProfileAnimesView({required this.controller, super.key});

  @override
  State<StatefulWidget> createState() => _ProfileAnimesViewState();
}

class _ProfileAnimesViewState extends State<ProfileAnimesView> {
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
        title: Text(AppLocalizations.of(context)!.animesAdded),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ChangeNotifierProvider.value(
                value: widget.controller,
                child: Consumer<AnimeWatchlistController>(
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
