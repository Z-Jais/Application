import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/border_element.dart';
import 'package:jais/components/platforms/platform_widget.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/entities/episode.dart';
import 'package:jais/mappers/display_mapper.dart';
import 'package:jais/url/url.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';
import 'package:jais/utils/dictionary.dart';
import 'package:jais/utils/utils.dart';

class LiteEpisodeWidget extends StatelessWidget {
  final Episode episode;

  const LiteEpisodeWidget({required this.episode, super.key});

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
      onTap: () async => URL.goOnUrl(episode.url),
      child: BorderElement(
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Badge(
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  toAnimate: false,
                  badgeColor: Colors.white,
                  badgeContent: PlatformWidget(platform: episode.platform),
                  child: image(
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
                  children: <Widget>[
                    Text(
                      episode.title.ifEmptyOrNull('＞﹏＜').replaceAll('\n', ' '),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Dictionary.getSeason()} ${episode.season}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${Dictionary.getEpisodeType(episode.episodeType)} ${episode.number} ${Dictionary.getLangType(episode.langType)}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(Icons.movie),
                        const SizedBox(width: 5),
                        Text(
                          Utils.printDuration(
                            Duration(seconds: episode.duration),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Il y a ${Utils.printTimeSince(DateTime.parse(episode.releaseDate))}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
