import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/decoration/border_decoration.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';
import 'package:jais/widgets/skeleton.dart';

class LiteEpisodeLoaderWidget extends StatelessWidget {
  const LiteEpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RepaintBoundary(
      child: BorderDecoration(
        child: Row(
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
