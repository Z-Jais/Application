import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';
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
      return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Wrap(
          children: [
            if (hTitle != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 7.5),
                child: hTitle,
              ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: hController,
              child: Row(children: hList!.toList()),
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
      if (horizontalWidget != null) horizontalWidget,
      if (vList.isNotEmpty) ...responsive(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    info('HVList', 'build');
    final List<Widget> children = list(context);

    return ListView.builder(
      controller: vController,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: children.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => children.elementAt(index),
    );
  }
}
