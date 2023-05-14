import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';
import 'package:jais/widgets/skeleton.dart';

class LiteEpisodeLoaderWidget extends StatelessWidget {
  const LiteEpisodeLoaderWidget({super.key});

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
        child: const Row(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Skeleton(height: Const.episodeImageHeight / 2),
                  Positioned(
                    top: 2,
                    right: 3,
                    child: PlatformLoaderWidget(),
                  )
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Skeleton(width: 150, height: 20),
                  SizedBox(height: 5),
                  Skeleton(width: 100, height: 20),
                  SizedBox(height: 5),
                  Skeleton(width: 100, height: 20),
                  SizedBox(height: 5),
                  Skeleton(width: 100, height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
