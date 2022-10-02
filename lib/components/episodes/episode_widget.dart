import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;

  const EpisodeWidget({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => launchUrl(
        Uri.parse(episode.url),
        mode: LaunchMode.externalApplication,
      ),
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
                  placeholder: (_, __) => const Skeleton(width: 20, height: 20),
                  errorWidget: (_, __, ___) =>
                      const Skeleton(width: 20, height: 20),
                  width: 20,
                  height: 20,
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
                  placeholder: (_, __) => const Skeleton(height: 200),
                  errorWidget: (_, __, ___) => const Skeleton(height: 200),
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
