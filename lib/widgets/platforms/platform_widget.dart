import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/models/platform.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/platforms/platform_loader_widget.dart';

class PlatformWidget extends StatelessWidget {
  final Platform platform;

  const PlatformWidget({required this.platform, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl:
          '${Const.instance.serverUrlWithHttpProtocol}/platforms/attachment/${platform.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(360),
          child: Image(image: imageProvider, fit: BoxFit.cover),
        );
      },
      placeholder: (_, __) => const PlatformLoaderWidget(),
      errorWidget: (_, __, ___) => const PlatformLoaderWidget(),
      width: Const.platformImageWith,
      height: Const.platformImageHeight,
    );
  }
}
