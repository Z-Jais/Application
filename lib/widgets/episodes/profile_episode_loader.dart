import 'package:flutter/material.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/skeleton.dart';

class ProfileEpisodeLoader extends StatelessWidget {
  const ProfileEpisodeLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 2.5),
        child: const SizedBox(
          width: Const.profileEpisodeImageWidth,
          height: Const.profileEpisodeImageHeight + 50,
          child: Column(
            children: [
              Skeleton(height: Const.profileEpisodeImageHeight),
              SizedBox(height: 7.5),
              Skeleton(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
