import 'package:flutter/material.dart';
import 'package:jais/controllers/app_controller.dart';
import 'package:jais/controllers/notification_controller.dart';
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
        builder: (context, anime, child) {
          return ElevatedButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  anime.inWatchlist
                      ? Icons.indeterminate_check_box_outlined
                      : Icons.add_box_outlined,
                  color: anime.inWatchlist ? Colors.red : Colors.green,
                ),
                const SizedBox(width: 5),
                Text(
                  anime.inWatchlist
                      ? 'Retirer de ma watchlist'
                      : 'Ajouter à ma watchlist',
                ),
              ],
            ),
            onPressed: () async {
              if (anime.inWatchlist) {
                await AppController.watchlist.remove(anime.uuid);
              } else {
                await AppController.watchlist.add(anime.uuid);
              }

              if (await NotificationController.instance.isWatchlist) {
                NotificationController.instance.subscribeToWatchlist();
              }

              anime.notify();
            },
          );
        },
      ),
    );
  }
}
