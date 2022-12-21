import 'package:flutter/cupertino.dart';
import 'package:jais/controllers/data_controller.dart';
import 'package:jais/controllers/url_controller.dart';
import 'package:jais/models/simulcast.dart';
import 'package:jais/widgets/simulcasts/simulcast_loader_widget.dart';
import 'package:jais/widgets/simulcasts/simulcast_widget.dart';

class SimulcastController
    extends DataController<Simulcast, SimulcastLoaderWidget, SimulcastWidget> {
  SimulcastController()
      : super(
          listener: false,
          firstLoad: false,
          limit: 9,
          loadingWidget: const SimulcastLoaderWidget(),
          fromJson: (json) => Simulcast.fromJson(json),
          toWidget: (simulcast) => SimulcastWidget(simulcast: simulcast),
        );

  @override
  Future<List<SimulcastWidget>> widgets() async {
    return URLController()
        .get(
          'https://beta-api.ziedelth.fr/simulcasts/country/fr',
        )
        .mapWithObjectIfOk((p0) => toWidget(fromJson(p0)));
  }

  List<Widget> setCurrent(Simulcast? simulcast) {
    if (simulcast == null) {
      return list;
    }

    final List<Widget> copy = list.toList();
    final int index = copy.indexWhere(
      (element) =>
          element is SimulcastWidget &&
          element.simulcast.uuid == simulcast.uuid,
    );

    if (index == -1) {
      return list;
    }

    copy[index] = SimulcastWidget(simulcast: simulcast, isSelected: true);
    return copy;
  }
}
