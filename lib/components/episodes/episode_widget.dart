import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/ads/video_ad.dart';
import 'package:jais/components/platforms/platform_widget.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/ad_utils.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/dictionary.dart';
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

  Widget image({double? height}) {
    return RoundBorderWidget(
      widget: CachedNetworkImage(
        imageUrl: '${UrlConst.episodeAttachment}${episode.uuid}',
        imageBuilder: (_, ImageProvider<Object> imageProvider) =>
            Image(image: imageProvider, fit: BoxFit.cover),
        placeholder: (_, __) => Skeleton(height: height),
        errorWidget: (_, __, ___) => Skeleton(height: height),
      ),
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
                PlatformWidget(platform: episode.platform),
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
              Dictionary.getEpisodeDetails(episode),
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
              image(height: Const.episodeImageHeight)
            else
              Expanded(
                child: image(),
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
