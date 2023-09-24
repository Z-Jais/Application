import 'package:flutter/material.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';

class FilterWatchlist extends StatefulWidget {
  const FilterWatchlist({super.key});

  @override
  State<FilterWatchlist> createState() => _FilterWatchlistState();
}

class _FilterWatchlistState extends State<FilterWatchlist> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Types',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final EpisodeType episodeType
              in FilterController.instance.episodeTypes)
            ListTile(
              title: Text(episodeType.toString()),
              trailing: Switch(
                value: FilterController.instance.watchlistEpisodeTypeFilter
                    .hasIn(episodeType.uuid),
                onChanged: (value) async {
                  await FilterController.instance.watchlistEpisodeTypeFilter
                      .toggle(episodeType.uuid);
                  setState(() {});
                },
              ),
            ),
          const SizedBox(height: 16),
          Text(
            'Langues',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final LangType langType in FilterController.instance.langTypes)
            ListTile(
              title: Text(langType.toString()),
              trailing: Switch(
                value: FilterController.instance.watchlistLangTypeFilter
                    .hasIn(langType.uuid),
                onChanged: (value) async {
                  await FilterController.instance.watchlistLangTypeFilter
                      .toggle(langType.uuid);
                  setState(() {});
                },
              ),
            ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          ListTile(
            title: const Text('Affichez les épisodes marqués comme "vu"'),
            trailing: Switch(
              value: FilterController.instance.episodeWatchedFilter.data == 1,
              onChanged: (value) async {
                await FilterController.instance.episodeWatchedFilter.invert();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
