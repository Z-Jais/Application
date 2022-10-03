import 'package:flutter/material.dart';
import 'package:jais/components/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/components/simulcasts/simulcast_widget.dart';
import 'package:jais/entities/simulcast.dart';
import 'package:jais/mappers/imapper.dart';
import 'package:jais/url/url_const.dart';

class SimulcastMapper extends IMapper<Simulcast> {
  SimulcastMapper({super.listener})
      : super(
          limit: 5,
          loaderWidget: const SimulcastLoaderWidget(),
          fromJson: Simulcast.fromJson,
          toWidget: (Simulcast simulcast) =>
              SimulcastWidget(simulcast: simulcast),
        );

  @override
  Future<void> updateCurrentPage() async => loadPage(UrlConst.simulcasts);

  List<Widget> toWidgetsSelected(Simulcast? simulcast) {
    if (simulcast == null) {
      return this.list;
    }

    // Copy list to avoid modifying the original list
    final List<Widget> list = this.list.toList();
    final int index = this.list.indexWhere(
          (Widget element) =>
              element is SimulcastWidget &&
              element.simulcast.uuid == simulcast.uuid,
        );

    if (index == -1) {
      return this.list;
    }

    // Change the same simulcast in the list to the selected simulcast
    list[index] = SimulcastWidget(simulcast: simulcast, isSelected: true);
    return list;
  }
}
