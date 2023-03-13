import 'package:flutter/material.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';

class FilterWatchlist extends StatefulWidget {
  const FilterWatchlist({super.key});

  @override
  _FilterWatchlistState createState() => _FilterWatchlistState();
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
              leading: Checkbox(
                value: FilterController.instance.watchlistEpisodeTypeFilter
                    .hasIn(episodeType.uuid),
                onChanged: (value) {
                  if (value == true) {
                    FilterController.instance.watchlistEpisodeTypeFilter
                        .add(episodeType.uuid);
                  } else {
                    FilterController.instance.watchlistEpisodeTypeFilter
                        .remove(episodeType.uuid);
                  }

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
              leading: Checkbox(
                value: FilterController.instance.watchlistLangTypeFilter
                    .hasIn(langType.uuid),
                onChanged: (value) {
                  if (value == true) {
                    FilterController.instance.watchlistLangTypeFilter
                        .add(langType.uuid);
                  } else {
                    FilterController.instance.watchlistLangTypeFilter
                        .remove(langType.uuid);
                  }

                  setState(() {});
                },
              ),
            ),
        ],
      ),
    );
  }
}
