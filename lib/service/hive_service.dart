import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String _boxName = 'userBox';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_boxName);
  }

  //* Box Instance Access
  Box<String> get _box => Hive.box<String>(_boxName);

  //* Create
  Future<void> addData(String data) async {
    await _box.add(data);
  }

  //* Read data
  List<String> getAllData() {
    return _box.values.toList();
  }

  //* Update
  Future<void> updateData(int index, String newData) async {
    await _box.putAt(index, newData);
  }

  //* Delete
  Future<void> deleteData(int index) async {
    await _box.deleteAt(index);
  }
}
