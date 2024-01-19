import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import '../view_model/HRExerciseViewModel.dart';
import 'package:sembast/utils/sembast_import_export.dart';
import 'package:path/path.dart';
import 'dart:convert';

/// Responsible for storing HR data to a Sembast database.
class HRStorage {
  HRExerciseViewModel monitor;
  StoreRef<int, Map<String, dynamic>>? store;
  Database? database;
  DumpManager? dumpManager;
  UploadManager? uploadManager;
  String? savename;
  var key;

  /// Initialize this storage by identifying which [monitor] it should save
  /// data for.
  HRStorage(this.monitor);

  /// Initialize the storage by opening the database and listening to HR events.
  Future<void> init() async {
    print(this.monitor.current_workout);
    print('Initializing storage, id: ${monitor.serial}');

    // Get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // Make sure it exists
    await dir.create(recursive: true);
    // Build the database path
    savename = this.monitor.current_workout! +
        DateTime.now().millisecondsSinceEpoch.toString();
    var path = join(dir.path, savename! + '.db');
    print(path);
    // Open the database
    database = await databaseFactoryIo.openDatabase(path);

    // Create a store with the name of the identifier of the monitor
    store = intMapStoreFactory.store(monitor.serial);

    // Listen to the monitor's HR event and add them to the store
    monitor.hbeat.listen((int hr) {
      // Create a JSON object with the timestamp and HR
      var json = {
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        'hr': hr,
      };

      // Add the json record to the database
      key = store?.add(database!, json);
    });

    // Initialize DumpManager and UploadManager
    dumpManager = DumpManager(this);
    dumpManager?.start();

    uploadManager = UploadManager(this);
    uploadManager?.startUpload();
  }

  /// The total number of HR samples collected in the database.
  Future<int> count() async => await store?.count(database!) ?? -1;

  /// Get the list of json objects which has not yet been uploaded.
  // TODO - implement this getJsonToUpload() method.
  Future<List<Map<String, int>>> getJsonToUpload() async => [{}];

  /// Dump the database to a text file with JSON data.
  Future<void> dump() async {
    print('Starting to dump database');
    int count = await this.count();

    // Export db, but only this store.
    Map<String, Object?> data =
        await exportDatabase(database!, storeNames: [monitor.serial!]);

    // Convert the JSON map to a string representation.
    String dataAsJson = json.encode(data);

    var rec = store!.record(1).get(database!);
    print(rec);

    // Build the file path and write the data
    var dir = await getApplicationDocumentsDirectory();
    var path = join(dir.path, savename! + '.json');
    await File(path).writeAsString(dataAsJson);
    print(
        "Database dumped in file '$path'. Total $count records successfully written to file.");
  }
}

/// A manager that dumps the database to a JSON file on a regular basis.
class DumpManager {
  HRStorage storage;
  Timer? dumper;

  DumpManager(this.storage);

  void start() {
    dumper = Timer.periodic(
        const Duration(seconds: 10), (_) async => await storage.dump());
  }

  void stop() => dumper?.cancel();
}

/// A manager that collects data from [storage] which has not been uploaded
/// yet and uploads this on a regular basis.
class UploadManager {
  HRStorage storage;
  Timer? uploadTimer;

  UploadManager(this.storage);

  void startUpload() {
    uploadTimer = Timer.periodic(const Duration(minutes: 10), (timer) async {
      var dataToUpload = await storage.getJsonToUpload();
      print('Uploading ${dataToUpload.length} json objects...');
      // Implement the upload logic here
    });
  }

  void stopUpload() => uploadTimer?.cancel();
}
