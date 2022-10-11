import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/platforms/platform_loader_widget.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/entities/platform.dart';
import 'package:jais/url/url_const.dart';
import 'package:jais/utils/const.dart';

class PlatformWidget extends StatelessWidget {
  final Platform platform;

  const PlatformWidget({required this.platform, super.key});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${UrlConst.platformAttachment}${platform.uuid}',
      imageBuilder: (_, ImageProvider<Object> imageProvider) {
        return RoundBorderWidget(
          radius: 360,
          widget: Image(image: imageProvider, fit: BoxFit.cover),
        );
      },
      placeholder: (_, __) => const PlatformLoaderWidget(),
      errorWidget: (_, __, ___) => const PlatformLoaderWidget(),
      width: Const.platformImageWith,
      height: Const.platformImageHeight,
    );
  }
}
