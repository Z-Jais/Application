import 'package:jais/controllers/datas/abstract_data_controller.dart';

class StringDataController extends AbstractDataController<String> {
  final String defaultValue;

  StringDataController(super.key, {this.defaultValue = ''});

  @override
  String load() {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    return sharedPreferences.getString(key) ?? defaultValue;
  }

  @override
  Future<void> save() async {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    await sharedPreferences.setString(key, data);
  }
}
