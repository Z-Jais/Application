import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/filter_controller.dart';
import 'package:jais/models/episodetype.dart';
import 'package:jais/models/langtype.dart';
import 'package:jais/widgets/categories/category.dart';
import 'package:jais/widgets/categories/category_button.dart';

class CategoryFilterWatchlist extends StatefulWidget {
  const CategoryFilterWatchlist({super.key});

  @override
  State<CategoryFilterWatchlist> createState() =>
      _CategoryFilterWatchlistState();
}

class _CategoryFilterWatchlistState extends State<CategoryFilterWatchlist> {
  @override
  Widget build(BuildContext context) {
    return Category(
      label: 'WATCHLIST',
      children: [
        CategoryButton(
          label: AppLocalizations.of(context)!.types,
          subCategory: true,
          icon: const Icon(Icons.video_label_rounded),
        ),
        for (final EpisodeType episodeType
            in FilterController.instance.episodeTypes)
          CategoryButton(
            label: episodeType.toStringTranslated(context),
            trailing: FilterController.instance.watchlistEpisodeTypeFilter
                    .hasIn(episodeType.uuid)
                ? const Icon(Icons.check)
                : const Icon(Icons.close),
            onTap: () async {
              await FilterController.instance.watchlistEpisodeTypeFilter
                  .toggle(episodeType.uuid);
              setState(() {});
            },
          ),
        CategoryButton(
          label: AppLocalizations.of(context)!.langs,
          subCategory: true,
          icon: const Icon(Icons.language),
        ),
        for (final LangType langType in FilterController.instance.langTypes)
          CategoryButton(
            label: langType.toStringTranslated(context),
            trailing: FilterController.instance.watchlistLangTypeFilter
                    .hasIn(langType.uuid)
                ? const Icon(Icons.check)
                : const Icon(Icons.close),
            onTap: () async {
              await FilterController.instance.watchlistLangTypeFilter
                  .toggle(langType.uuid);
              setState(() {});
            },
          ),
      ],
    );
  }
}
