import 'dart:convert';
import 'dart:io';

import 'package:jais/controllers/datas/abstract_data_controller.dart';

class CollectionDataController extends AbstractDataController<List<String>> {
  CollectionDataController(super.key, {super.limit});

  @override
  List<String> load() {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    return sharedPreferences.getStringList(key) ?? <String>[];
  }

  @override
  Future<void> save() async {
    if (!isInit) {
      throw Exception('DataCollection is not initialized');
    }

    await sharedPreferences.setStringList(key, data);
  }

  bool hasIn(String uuid) => data.contains(uuid);

  Future<void> add(String uuid) async {
    if (hasIn(uuid)) {
      return;
    }

    if (limit != null && data.length >= limit!) {
      data.removeAt(0);
    }

    data.add(uuid);
    await save();
  }

  Future<void> addAll(Iterable<String> uuids) async {
    for (final String uuid in uuids) {
      if (hasIn(uuid)) {
        continue;
      }

      if (limit != null && data.length >= limit!) {
        data.removeAt(0);
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

  Future<void> toggle(String uuid) async {
    if (hasIn(uuid)) {
      await remove(uuid);
    } else {
      await add(uuid);
    }
  }

  String toGzip() {
    return base64Encode(gzip.encode(utf8.encode(jsonEncode(data))));
  }
}
