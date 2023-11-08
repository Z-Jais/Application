import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/disposing_image.dart';
import 'package:jais/widgets/opacity_container.dart';
import 'package:jais/widgets/skeleton.dart';
import 'package:provider/provider.dart';

class EpisodeImage extends StatelessWidget {
  final Episode episode;
  final double height;

  const EpisodeImage({
    required this.episode,
    this.height = Const.episodeImageHeight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      imageUrl:
          '${Const.instance.serverUrlWithHttpProtocol}/episodes/attachment/${episode.uuid}',
      imageBuilder: (context, imageProvider) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Stack(
            children: [
              DisposingImage(
                image: Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: height,
                ),
              ),
              Positioned(
                bottom: 5,
                right: 5,
                child: OpacityContainer(
                  text: Utils.instance
                      .formatDuration(Duration(seconds: episode.duration)),
                ),
              ),
              ChangeNotifierProvider.value(
                value: episode,
                child: Consumer<Episode>(
                  builder: (context, value, child) {
                    return value.isSeen
                        ? const Positioned(
                            bottom: 5,
                            left: 5,
                            child: OpacityContainer(
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.visibility,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Vu',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  },
                ),
              ),
            ],
          ),
        );
      },
      placeholder: (context, url) => Skeleton(height: height),
      errorWidget: (context, url, error) => Skeleton(height: height),
    );
  }
}
