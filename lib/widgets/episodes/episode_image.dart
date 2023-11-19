import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jais/controllers/profile_controller.dart';
import 'package:jais/models/episode.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/disposing_image.dart';
import 'package:jais/widgets/opacity_container.dart';
import 'package:jais/widgets/skeleton.dart';
import 'package:provider/provider.dart';

class EpisodeImage extends StatelessWidget {
  final Episode episode;
  final double width;
  final double height;
  final bool showInWatchlist;

  const EpisodeImage({
    required this.episode,
    this.width = double.infinity,
    this.height = Const.episodeImageHeight,
    this.showInWatchlist = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
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
                  width: width,
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
              if (showInWatchlist)
                ChangeNotifierProvider.value(
                  value: episode,
                  child: Consumer<Episode>(
                    builder: (context, value, child) {
                      return ProfileController.instance
                              .isEpisodeInWatchlist(episode)
                          ? Positioned(
                              bottom: 5,
                              left: 5,
                              child: OpacityContainer(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.visibility,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      AppLocalizations.of(context)!.seen,
                                      style: const TextStyle(
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
      placeholder: (context, url) => Skeleton(
        width: width,
        height: height,
      ),
      errorWidget: (context, url, error) => Skeleton(
        width: width,
        height: height,
      ),
    );
  }
}
