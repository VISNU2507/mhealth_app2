import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class HRStorageViewModel {
  Future<dynamic> readJsonFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        var input = await file.readAsString();
        var map = jsonDecode(input);
        print(map);
        return map; // Return the entire JSON map
      } else {
        print('File does not exist: $filePath');
        return null; // Return null or handle appropriately
      }
    } catch (exception) {
      print('An error occurred while reading the file: $exception');
      return null; // Return null or handle appropriately
    }
  }

  Future<List<Map<String, dynamic>>> findFiles() async {
    List<Map<String, dynamic>> filesData = [];
    final dir = await getApplicationDocumentsDirectory();
    final List<FileSystemEntity> entities = await dir.list().toList();

    List<File> jsonFiles = entities
        .whereType<File>()
        .where((file) => file.path.endsWith('.json'))
        .toList();

    // Sort the files by their timestamp
    jsonFiles
        .sort((a, b) => _getFileTimestamp(b).compareTo(_getFileTimestamp(a)));

    for (final file in jsonFiles) {
      var timestamp = _getFileTimestamp(file);
      var formattedTimestamp = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(timestamp); // Requires 'intl' package
      var data = await readJsonFile(file.path);
      filesData.add({
        'name': basename(file.path),
        'datetime': formattedTimestamp,
        'data': data
      });
    }
    return filesData;
  }

  DateTime _getFileTimestamp(File file) {
    try {
      String filename = basenameWithoutExtension(file.path);
      // Extract the timestamp using RegExp - adjust the pattern to match your filenames
      RegExp regExp = RegExp(r"(\d+)$");
      var matches = regExp.firstMatch(filename);
      if (matches != null && matches.groupCount >= 1) {
        // Assuming the timestamp is in milliseconds since epoch
        var timestamp = int.parse(matches.group(1)!);
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
    } catch (e) {
      print('Error parsing file timestamp: $e');
    }
    return DateTime.now(); // Fallback to current time if parsing fails
  }
}
