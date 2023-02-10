import 'package:flutter/material.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';

class FilterWatchlist extends StatefulWidget {
  final VoidCallback? onFilterChanged;

  const FilterWatchlist({this.onFilterChanged, super.key});

  @override
  _FilterWatchlistState createState() => _FilterWatchlistState();
}

class _FilterWatchlistState extends State<FilterWatchlist> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      expandedAlignment: Alignment.centerLeft,
      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      childrenPadding: const EdgeInsets.only(left: 16, right: 16),
      onExpansionChanged: (value) {
        if (value == false) {
          widget.onFilterChanged?.call();
        }
      },
      title: const Text('Filtres'),
      children: [
        Text(
          'Types',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: FilterController.instance.episodeTypes.length,
          itemBuilder: (context, index) {
            final EpisodeType episodeType =
                FilterController.instance.episodeTypes[index];

            return ListTile(
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
            );
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Langues',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: FilterController.instance.langTypes.length,
          itemBuilder: (context, index) {
            final LangType langType =
                FilterController.instance.langTypes[index];

            return ListTile(
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
            );
          },
        ),
      ],
    );
  }
}
