import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/ads/video_ad.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/utils/ad_utils.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;

  const EpisodeWidget({required this.episode, super.key});

  Future<bool> redirectToEpisode() {
    return launchUrl(
      Uri.parse(episode.url),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (AdUtils.canShowAd) {
          showVideoAd(
            callback: (_) async => redirectToEpisode(),
          );
        } else {
          redirectToEpisode();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      'https://ziedelth.fr/images/platforms/${episode.platform.image}',
                  imageBuilder: (_, ImageProvider<Object> imageProvider) =>
                      RoundBorderWidget(
                    radius: 360,
                    widget: Image(image: imageProvider, fit: BoxFit.cover),
                  ),
                  placeholder: (_, __) => const Skeleton(width: Const.platformImageWith, height: Const.platformImageHeight),
                  errorWidget: (_, __, ___) =>
                      const Skeleton(width: Const.platformImageWith, height: Const.platformImageHeight),
                  width: Const.platformImageWith,
                  height: Const.platformImageHeight,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    episode.anime.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              episode.title.ifEmptyOrNull('＞﹏＜').replaceAll('\n', ' '),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'Saison ${episode.season} • ${episode.episodeType.name} ${episode.number} ${episode.langType.name}',
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: <Widget>[
                const Icon(Icons.movie),
                const SizedBox(width: 5),
                Text(Utils.printDuration(Duration(seconds: episode.duration))),
              ],
            ),
            const SizedBox(height: 10),
            if (DisplayMapper.isOnMobile(context))
              RoundBorderWidget(
                widget: CachedNetworkImage(
                  imageUrl: episode.image,
                  imageBuilder: (_, ImageProvider<Object> imageProvider) =>
                      Image(image: imageProvider, fit: BoxFit.cover),
                  placeholder: (_, __) => const Skeleton(height: Const.episodeImageHeight),
                  errorWidget: (_, __, ___) => const Skeleton(height: Const.episodeImageHeight),
                ),
              )
            else
              Expanded(
                child: RoundBorderWidget(
                  widget: CachedNetworkImage(
                    imageUrl: episode.image,
                    imageBuilder: (_, ImageProvider<Object> imageProvider) =>
                        Image(image: imageProvider, fit: BoxFit.cover),
                    placeholder: (_, __) => const Skeleton(),
                    errorWidget: (_, __, ___) => const Skeleton(),
                  ),
                ),
              ),
            const SizedBox(height: 10),
            Text(
              'Il y a ${Utils.printTimeSince(DateTime.parse(episode.releaseDate))}',
            ),
          ],
        ),
      ),
    );
  }
}
