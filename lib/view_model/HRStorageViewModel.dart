import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'dart:io';

class HRStorageViewModel {
  Future readJsonFile(String filePath) async {
    var input = await File(filePath).readAsString();
    var map = jsonDecode(input);
    print(map);
    print(map['stores'].length);
    print(map['stores'].length);

    final firstEl = map['stores'].first;
    print(firstEl['values']);
    return firstEl['values'];
  }

  Future<void> findFiles() async {
    final dir = await getApplicationDocumentsDirectory();

    final List<FileSystemEntity> entities = await dir.list().toList();

    for (final entity in entities) {
      if (entity is File && entity.path.endsWith('.json')) {
        print(entity);
        var filePath = entity.path;
        var data = await readJsonFile(filePath);
        print('________________________');
        print(data);
      }
    }
  }
}
