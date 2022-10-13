import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/image_network.dart';
import 'package:jais/components/platforms/platform_widget.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/dictionary.dart';
import 'package:jais/utils/utils.dart';

class EpisodeWidget extends StatelessWidget {
  final Episode episode;

  const EpisodeWidget({required this.episode, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => URL.goOnUrl(episode.url),
      child: BorderElement(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
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
                  Text(
                    Utils.printDuration(Duration(seconds: episode.duration)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (DisplayMapper.isOnMobile(context))
                ImageNetwork(
                  url: '${UrlConst.episodeAttachment}${episode.uuid}',
                  width: double.infinity,
                )
              else
                Expanded(
                  child: ImageNetwork(
                    url: '${UrlConst.episodeAttachment}${episode.uuid}',
                  ),
                ),
              const SizedBox(height: 10),
              Text(
                'Il y a ${Utils.printTimeSince(DateTime.parse(episode.releaseDate))}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
