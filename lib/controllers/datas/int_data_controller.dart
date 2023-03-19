import 'package:jais/controllers/datas/abstract_data_controller.dart';

class IntDataController extends AbstractDataController<int> {
  IntDataController(super.key);

  @override
  int load() {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    return sharedPreferences.getInt(key) ?? 0;
  }

  @override
  Future<void> save() async {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    await sharedPreferences.setInt(key, data);
  }

  Future<void> invert() async {
    data = data == 0 ? 1 : 0;
    await save();
  }
}
