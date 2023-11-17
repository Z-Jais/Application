import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/animes/profile_anime_controller.dart';
import 'package:jais/controllers/episodes/profile_episode_controller.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  final ProfileEpisodeController _episodeWatchlistController =
      ProfileEpisodeController();
  final ProfileAnimeController _animeWatchlistController =
      ProfileAnimeController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _episodeWatchlistController.load();
      _animeWatchlistController.load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (ProfileController.instance.profile != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Category(
                  label: 'STATISTIQUES AVANCÉES',
                  children: [
                    CategoryButton(
                      label:
                          'Animé(s) : ${ProfileController.instance.animesInWatchlist.length}',
                      icon: const Icon(Icons.video_library),
                    ),
                    CategoryButton(
                      label:
                          'Épisode(s) vu(s) : ${ProfileController.instance.episodesInWatchlist.length}',
                      icon: const Icon(Icons.subscriptions),
                    ),
                    CategoryButton(
                      label:
                          'Durée totale : ${Utils.instance.fullFormatDuration(Duration(seconds: ProfileController.instance.profile!.totalDurationSeen))}',
                      icon: const Icon(Icons.watch_later),
                    ),
                  ],
                ),
              ),
            Category(
              label: AppLocalizations.of(context)!.episodesViewed.toUpperCase(),
              trailing: GestureDetector(
                child: const Icon(Icons.navigate_next),
                onTap: () => Navigator.pushNamed(context, '/profile/episodes'),
              ),
              child: ChangeNotifierProvider.value(
                value: _episodeWatchlistController,
                child: Consumer<ProfileEpisodeController>(
                  builder: (context, value, child) {
                    if (value.nothingToShow()) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.history),
                              const SizedBox(height: 10),
                              Text(AppLocalizations.of(context)!.noHistory),
                            ],
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: value.list),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Category(
              label: AppLocalizations.of(context)!.animesAdded.toUpperCase(),
              trailing: GestureDetector(
                child: const Icon(Icons.navigate_next),
                onTap: () => Navigator.pushNamed(context, '/profile/animes'),
              ),
              child: ChangeNotifierProvider.value(
                value: _animeWatchlistController,
                child: Consumer<ProfileAnimeController>(
                  builder: (context, value, child) {
                    if (value.nothingToShow()) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.history),
                              const SizedBox(height: 10),
                              Text(AppLocalizations.of(context)!.noHistory),
                            ],
                          ),
                        ),
                      );
                    }

                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: value.list),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Compte créé le ${Utils.instance.toDateTimeString(DateTime.parse(ProfileController.instance.profile!.creationDate))}',
            ),
          ],
        ),
      ),
    );
  }
}
