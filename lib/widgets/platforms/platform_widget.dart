import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/platform.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/disposing_image.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';

class PlatformWidget extends StatelessWidget {
  final Platform platform;

  const PlatformWidget({required this.platform, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: Const.platformImageWith,
      height: Const.platformImageHeight,
      fit: BoxFit.cover,
      imageUrl:
          '${Const.instance.serverUrlWithHttpProtocol}/platforms/attachment/${platform.uuid}',
      imageBuilder: (context, imageProvider) {
        return ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(360)),
          child: DisposingImage(
            image: Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: Const.platformImageWith,
              height: Const.platformImageHeight,
            ),
          ),
        );
      },
      placeholder: (context, url) => const PlatformLoaderWidget(),
      errorWidget: (context, url, error) => const PlatformLoaderWidget(),
    );
  }
}
