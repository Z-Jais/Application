import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';
import 'package:jais/widgets/skeleton.dart';

class EpisodeLoaderWidget extends StatelessWidget {
  const EpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 10),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          PlatformLoaderWidget(),
                          SizedBox(width: 7.5),
                          Expanded(
                            child: Skeleton(
                              height: Const.platformImageHeight,
                              width: 150,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Skeleton(height: 20),
                      SizedBox(height: 10),
                      Skeleton(width: 200, height: 20),
                      SizedBox(height: 5),
                      Skeleton(width: 250, height: 15),
                      SizedBox(height: 5),
                      Skeleton(width: 100, height: 15),
                    ],
                  ),
                ),
                SizedBox(width: 10),
                Skeleton(
                  width: Const.animeImageWith,
                  height: Const.animeImageHeight,
                ),
              ],
            ),
            SizedBox(height: 10),
            Skeleton(height: Const.episodeImageHeight),
            SizedBox(height: 10),
            Skeleton(width: 200, height: 20),
          ],
        ),
      ),
    );
  }
}
