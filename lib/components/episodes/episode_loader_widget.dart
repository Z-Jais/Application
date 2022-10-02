import 'package:flutter/material.dart';
import 'package:jais/components/skeleton.dart';
import 'package:jais/mappers/display_mapper.dart';

class EpisodeLoaderWidget extends StatelessWidget {
  const EpisodeLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            children: const <Widget>[
              Skeleton(width: 20, height: 20),
              SizedBox(width: 10),
              Expanded(child: Skeleton(height: 20)),
            ],
          ),
          const SizedBox(height: 10),
          const Skeleton(width: 150, height: 20),
          const SizedBox(height: 5),
          const Skeleton(width: 250, height: 20),
          const SizedBox(height: 5),
          const Skeleton(width: 100, height: 20),
          const SizedBox(height: 10),
          if (DisplayMapper.isOnMobile(context))
            const Skeleton(height: 200)
          else
            const Expanded(child: Skeleton()),
          const SizedBox(height: 10),
          const Skeleton(width: 200, height: 20),
        ],
      ),
    );
  }
}
