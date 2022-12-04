import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

abstract class AbstractData<T> {
  final String key;
  late final SharedPreferences _sharedPreferences;
  bool _isInit = false;
  late T data;

  AbstractData(this.key);

  Future<void> init() async {
    if (_isInit) {
      return;
    }

    _sharedPreferences = await SharedPreferences.getInstance();
    _isInit = true;
    data = load();
  }

  T load();

  Future<void> save();
}

class DataCollection extends AbstractData<List<String>> {
  DataCollection(super.key);

  @override
  List<String> load() {
    if (!_isInit) {
      throw Exception('DataCollection is not initialized');
    }

    return _sharedPreferences.getStringList(key) ?? <String>[];
  }

  @override
  Future<void> save() async {
    if (!_isInit) {
      throw Exception('DataCollection is not initialized');
    }

    await _sharedPreferences.setStringList(key, data);
  }

  bool hasIn(String uuid) => data.contains(uuid);

  Future<void> add(String uuid) async {
    if (hasIn(uuid)) {
      return;
    }

    data.add(uuid);
    await save();
  }

  Future<void> addAll(Iterable<String> uuids) async {
    for (final String uuid in uuids) {
      if (hasIn(uuid)) {
        continue;
      }

      data.add(uuid);
    }

    await save();
  }

  Future<void> remove(String uuid) async {
    if (!hasIn(uuid)) {
      return;
    }

    data.remove(uuid);
    await save();
  }

  String toGzip() {
    return base64Encode(gzip.encode(utf8.encode(jsonEncode(data))));
  }
}

class DataMap extends AbstractData<Map<String, dynamic>> {
  DataMap(super.key);

  @override
  Map<String, dynamic> load() {
    if (!_isInit) {
      throw Exception('DataCollection is not initialized');
    }

    final String? data = _sharedPreferences.getString(key);

    if (data == null) {
      return <String, dynamic>{};
    }

    return jsonDecode(data);
  }

  @override
  Future<void> save() async {
    if (!_isInit) {
      throw Exception('DataCollection is not initialized');
    }

    await _sharedPreferences.setString(key, jsonEncode(data));
  }

  bool hasIn(String key) => data.containsKey(key);

  dynamic get(String key) => data[key];

  Future<void> add(String key, dynamic value) async {
    if (hasIn(key) && data[key] == value) {
      return;
    }

    data[key] = value;
    await save();
  }

  Future<void> remove(String key) async {
    if (!hasIn(key)) {
      return;
    }

    data.remove(key);
    await save();
  }

  int count(dynamic value) {
    return data.values.where((dynamic v) => v == value).length;
  }
}
