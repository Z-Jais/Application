import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/widgets/roundborder_widget.dart';
import 'package:jais/widgets/skeleton.dart';

class EpisodeImage extends StatelessWidget {
  final Episode episode;
  final double? height;

  const EpisodeImage({required this.episode, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${UrlConst.episodeAttachment}${episode.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        final bool needStack = episode.season == 1 &&
            episode.number == 1 &&
            episode.anime.releaseDate == episode.releaseDate;

        return RoundBorderWidget(
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
                      child: RoundBorderWidget(
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
    );
  }
}
