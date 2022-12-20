import 'package:flutter/material.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/widgets/border_element.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';
import 'package:jais/widgets/skeleton.dart';

class LiteEpisodeLoaderWidget extends StatelessWidget {
  const LiteEpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderElement(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: const <Widget>[
                Skeleton(height: Const.episodeImageHeight / 2),
                Positioned(
                  top: 2,
                  right: 3,
                  child: PlatformLoaderWidget(),
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
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
    );
  }
}
