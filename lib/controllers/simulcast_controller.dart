import 'package:flutter/material.dart';
import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/utils.dart';
import 'package:jais/widgets/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class SimulcastController
    extends DataController<Simulcast, SimulcastLoaderWidget, SimulcastWidget> {
  SimulcastController({required super.notifyListenersCallback})
      : super(
          listener: false,
          limit: 9,
          loadingWidget: const SimulcastLoaderWidget(),
          fromJson: (json) => Simulcast.fromJson(json),
          toWidget: (simulcast) => SimulcastWidget(simulcast: simulcast),
        );

  @override
  Future<List<SimulcastWidget>> widgets() async {
    return URLController.instance
        .get(
          '${Const.instance.serverUrlWithHttpProtocol}/simulcasts/country/${Const.selectedCountry}',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }

  List<Widget> setCurrent(Simulcast? simulcast) {
    if (simulcast == null) {
      return list;
    }

    List<Widget> copy = copyList(list);
    final int index = findWidgetIndex(copy, simulcast);

    if (index != -1) {
      copy = updateWidgetInList(copy, index, simulcast);
    }

    return copy;
  }

  List<Widget> copyList(List<Widget> list) {
    return List<Widget>.from(list);
  }

  int findWidgetIndex(List<Widget> list, Simulcast simulcast) {
    return list.indexWhere(
      (element) =>
          element is SimulcastWidget &&
          element.simulcast.uuid == simulcast.uuid,
    );
  }

  List<Widget> updateWidgetInList(
    List<Widget> list,
    int index,
    Simulcast simulcast,
  ) {
    list[index] = SimulcastWidget(simulcast: simulcast, isSelected: true);
    return list;
  }
}
