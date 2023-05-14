import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class EpisodeImage extends StatelessWidget {
  final Episode episode;
  final double? height;

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
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        final bool needStack = episode.season == 1 &&
            episode.number == 1 &&
            episode.anime.releaseDate == episode.releaseDate;

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            children: <Widget>[
              Image(
                image: imageProvider,
                fit: BoxFit.cover,
                width: double.infinity,
                height: height,
              ),
              if (needStack)
                Positioned(
                  top: 0,
                  right: 0,
                  child: ColoredBox(
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
              Positioned(
                bottom: 5,
                right: 5,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 2.5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.75),
                  ),
                  child: Text(
                    Utils.instance
                        .printDuration(Duration(seconds: episode.duration)),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      placeholder: (_, __) => Skeleton(height: height),
      errorWidget: (_, __, ___) => Skeleton(height: height),
    );
  }
}
