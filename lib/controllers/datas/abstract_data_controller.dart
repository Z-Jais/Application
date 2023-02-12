import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractDataController<T> {
  final String key;
  late final SharedPreferences sharedPreferences;
  bool firstInit = true;
  bool isInit = false;
  late T data;

  AbstractDataController(this.key);

  Future<void> init() async {
    if (isInit) {
      return;
    }

    sharedPreferences = await SharedPreferences.getInstance();
    isInit = true;
    data = load();
    firstInit = !sharedPreferences.containsKey(key);
  }

  T load();

  Future<void> save();
}
