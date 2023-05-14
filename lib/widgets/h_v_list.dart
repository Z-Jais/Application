import 'package:flutter/material.dart';
import 'package:jais/utils.dart';

class HVList extends StatelessWidget {
  final Widget? hTitle;
  final bool hCenter;
  final ScrollController? hController;
  final Iterable<Widget>? hList;
  final Widget? hChild;

  final ScrollController? vController;
  final Iterable<Widget> vList;

  const HVList({
    this.hTitle,
    this.hCenter = false,
    this.hController,
    this.hList,
    this.hChild,
    this.vController,
    required this.vList,
    super.key,
  });

  List<Widget> responsive(BuildContext context) {
    if (context.isOnMobile) {
      return vList.toList();
    } else {
      return Utils.instance.separate(vList.toList());
    }
  }

  Widget? getHorizontalWidget(BuildContext context) {
    if (hChild != null) {
      return hChild;
    } else if (hList != null && hList!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment:
              hCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            if (hTitle != null) ...[
              hTitle!,
              const SizedBox(height: 7.5),
            ],
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: hController,
              child: Row(
                children: [
                  ...hList!,
                ],
              ),
            ),
          ],
        ),
      );
    }

    return null;
  }

  List<Widget> list(BuildContext context) {
    final horizontalWidget = getHorizontalWidget(context);

    return [
      if (horizontalWidget != null) ...[
        horizontalWidget,
      ],
      if (vList.isNotEmpty) ...responsive(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = list(context);

    return ListView.builder(
      controller: vController,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: children.length,
      itemBuilder: (context, index) => children.elementAt(index),
    );
  }
}
