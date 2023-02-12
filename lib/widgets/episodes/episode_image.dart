import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/decoration/round_border_decoration.dart';
import 'package:jais/widgets/skeleton.dart';

class EpisodeImage extends StatelessWidget {
  final Episode episode;
  final double? height;

  const EpisodeImage({required this.episode, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CachedNetworkImage(
        imageUrl:
            'https://${Const.serverUrl}/episodes/attachment/${episode.uuid}',
        imageBuilder: (_, ImageProvider<Object> imageProvider) {
          final bool needStack = episode.season == 1 &&
              episode.number == 1 &&
              episode.anime.releaseDate == episode.releaseDate;

          return RoundBorderDecoration(
            widget: needStack
                ? Stack(
                    children: <Widget>[
                      Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: RoundBorderDecoration(
                          widget: ColoredBox(
                            color: Colors.red[800]!,
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.new_releases,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          );
        },
        placeholder: (_, __) => Skeleton(height: height),
        errorWidget: (_, __, ___) => Skeleton(height: height),
      ),
    );
  }
}
