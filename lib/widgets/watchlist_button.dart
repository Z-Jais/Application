import 'package:flutter/material.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/models/anime.dart';
import 'package:provider/provider.dart';

class WatchlistButton extends StatelessWidget {
  final Anime anime;

  const WatchlistButton({
    required this.anime,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: anime,
      child: Consumer<Anime>(
        builder: (context, value, child) {
          final bool inWatchlist =
              ProfileController.instance.isAnimeInWatchlist(value);

          return ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  inWatchlist
                      ? Icons.indeterminate_check_box_outlined
                      : Icons.add_box_outlined,
                  color: inWatchlist ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 5),
                Text(
                  inWatchlist
                      ? 'Retirer de ma watchlist'
                      : 'Ajouter à ma watchlist',
                ),
              ],
            ),
            onPressed: () async {
              await ProfileController.instance.toggleAnimeInWatchlist(value);
            },
          );
        },
      ),
    );
  }
}
