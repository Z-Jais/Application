import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/platforms/platform_loader_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/mappers/device_mapper.dart';
import 'package:jais/utils/const.dart';

class EpisodeLoaderWidget extends StatelessWidget {
  const EpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderElement(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      children: const <Widget>[
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
                    const SizedBox(height: 10),
                    const Skeleton(height: 20),
                    const SizedBox(height: 10),
                    const Skeleton(width: 200, height: 20),
                    const SizedBox(height: 5),
                    const Skeleton(width: 250, height: 15),
                    const SizedBox(height: 5),
                    const Skeleton(width: 100, height: 15)
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Skeleton(
                width: Const.animeImageWith,
                height: Const.animeImageHeight,
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (DeviceMapper.isOnMobile(context))
            const Skeleton(height: Const.episodeImageHeight)
          else
            const Expanded(child: Skeleton()),
          const SizedBox(height: 10),
          const Skeleton(width: 200, height: 20),
        ],
      ),
    );
  }
}
