import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jais/components/roundborder_widget.dart';
import 'package:jais/components/skeleton.dart';

class ImageNetwork extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;

  const ImageNetwork({required this.url, this.width, this.height, super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Image(
        image: NetworkImage(url),
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) {
          return Skeleton(width: width, height: height);
        },
        loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return RoundBorderWidget(widget: child);
          }

          return Skeleton(width: width, height: height);
        },
      );

      // return Image.network(
      //   url,
      //   width: width,
      //   height: height,
      //   fit: BoxFit.cover,
      //   errorBuilder: (_, __, ___) {
      //     return Skeleton(width: width, height: height);
      //   },
      //   loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
      //     if (loadingProgress == null) {
      //       return SizedBox(
      //         width: width,
      //         height: height,
      //         child: RoundBorderWidget(widget: child),
      //       );
      //     }
      //
      //     return Skeleton(width: width, height: height);
      //   },
      // );
    }

    return RoundBorderWidget(
      widget: CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (_, ImageProvider<Object> imageProvider) =>
            Image(image: imageProvider, fit: BoxFit.cover),
        placeholder: (_, __) => Skeleton(width: width, height: height),
        errorWidget: (_, __, ___) => Skeleton(width: width, height: height),
        width: width,
        height: height,
      ),
    );
  }
}
