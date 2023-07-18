import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';

class DisposingImage extends StatefulWidget {
  final Image image;

  const DisposingImage({required this.image, super.key});

  @override
  State<DisposingImage> createState() => _DisposingImageState();
}

class _DisposingImageState extends State<DisposingImage> {
  @override
  Widget build(BuildContext context) {
    return widget.image;
  }

  @override
  void dispose() {
    debug('DisposingImage', 'dispose()');
    imageCache.evict(widget.image);
    super.dispose();
  }
}
