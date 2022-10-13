import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/platforms/platform_loader_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/utils/const.dart';

class LiteEpisodeLoaderWidget extends StatelessWidget {
  const LiteEpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderElement(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Badge(
              position: BadgePosition.topEnd(top: 0, end: 0),
              toAnimate: false,
              badgeColor: Colors.white,
              badgeContent: const PlatformLoaderWidget(),
              child: Skeleton(
                height: DisplayMapper.isOnMobile(context, 1200)
                    ? Const.episodeImageHeight
                    : null,
              ),
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
                SizedBox(height: 10),
                Skeleton(width: 200, height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
