import 'package:flutter/material.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/utils.dart';

class HVList extends StatelessWidget {
  final Widget? hTitle;
  final bool hCenter;
  final ScrollController? hController;
  final List<Widget>? hList;
  final Widget? hChild;

  final ScrollController? vController;
  final List<Widget> vList;

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

  List<Widget> _createResponsiveList(BuildContext context) {
    return context.isOnMobile ? vList : Utils.instance.separate(vList);
  }

  Widget? _createHorizontalWidget(BuildContext context) {
    if (hChild != null) {
      return hChild;
    } else if (hList != null && hList!.isNotEmpty) {
      return _buildContainer(context);
    }
    return null;
  }

  List<Widget> _createList(BuildContext context) {
    final horizontalWidget = _createHorizontalWidget(context);
    return [
      if (horizontalWidget != null) horizontalWidget,
      if (vList.isNotEmpty) ..._createResponsiveList(context),
    ];
  }

  Container _buildContainer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: Utils.instance.buildBoxDecoration(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            hCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          if (hTitle != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 7.5),
              child: hTitle,
            ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: hController,
            child: Row(children: hList!),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    info('HVList', 'build');
    final List<Widget> children = _createList(context);

    return ListView.builder(
      controller: vController,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: children.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => children[index],
    );
  }
}
