import 'package:flutter/material.dart';
import 'package:jais/controllers/anime_tab_controller.dart';
import 'package:jais/controllers/logger.dart';
import 'package:jais/widgets/h_v_list.dart';
import 'package:provider/provider.dart';

class AnimeTab extends StatefulWidget {
  const AnimeTab({super.key});

  @override
  State<StatefulWidget> createState() => _AnimeTabState();
}

class _AnimeTabState extends State<AnimeTab> {
  final _controller = AnimeTabController();

  @override
  void initState() {
    _controller.setup();
    WidgetsBinding.instance.addPostFrameCallback((_) => _controller.init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    info('AnimeTab', 'build()');
    return ChangeNotifierProvider.value(
      value: _controller,
      child: Consumer<AnimeTabController>(
        builder: (_, value, __) {
          return HVList(
            hCenter: true,
            hController: _controller.simulcastController.scrollController,
            hList: _controller.simulcastWidgets,
            vController: _controller.animeController.scrollController,
            vList: _controller.animeController.list,
          );
        },
      ),
    );
  }
}
