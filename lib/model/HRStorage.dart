import 'package:flutter/material.dart';
import '../view_model/HRExerciseViewModel.dart';
import 'dart:async';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

/// Responsible for storing HR data to a Sembast database.
class Storage {
  HRViewModel monitor;
  StoreRef? store;
  var database;

  /// Initialize this storage by identifying which [monitor] is should save
  /// data for.
  Storage(this.monitor);

  /// Initialize the storage by opening the database and listening to HR events.
  Future<void> init() async {
    print('Initializing storage, id: ${monitor.serial}');

    // Get the application documents directory
    var dir = await getApplicationDocumentsDirectory();
    // Make sure it exists
    await dir.create(recursive: true);
    // Build the database path
    var path = join(dir.path, 'hr_monitor.db');
    print(path);
    // Open the database
    database = await databaseFactoryIo.openDatabase(path);

    // Create a store with the name of the identifier of the monitor and which
    // can hold maps indexed by an int.
    store = intMapStoreFactory.store(monitor.serial);

    // Create a JSON object with the timestamp and HR:
    //   {timestamp: 1699880580494, hr: 57}
    Map<String, int> json = {};

    // Listen to the monitor's HR event and add them to the store.

    monitor.hbeat.listen((int hr) {
      // Timestamp the HR reading.
      json['timestamp'] = DateTime.now().millisecondsSinceEpoch;
      json['hr'] = hr;
      print(hr);
      print(DateTime.now().millisecondsSinceEpoch);

      // Add the json record to the database
      store?.add(database, json);
    });
  }

  /// The total number of HR samples collected in the database.
  ///
  /// Example use:
  ///    count().then((count) => print('>> size: $count'));
  ///
  /// Returns -1 if unknown.
  Future<int> count() async => await store?.count(database) ?? -1;

  /// Get the list of json objects which has not yet been uploaded.
  // TODO - implement this getJsonToUpload() method.
  Future<List<Map<String, int>>> getJsonToUpload() async {
    final finder =
        Finder(sortOrders: [SortOrder('timestamp')]); // Sort by timestamp
    final recordSnapshots = await store!.find(database, finder: finder);
    return recordSnapshots
        .map((snapshot) => snapshot.value as Map<String, int>)
        .toList();
  }
}

/// A manager that collects data from [storage] which has not been uploaded
/// yet and uploads this on regular basis.
class UploadManager {
  Storage storage;
  Timer? uploadTimer;

  /// Create an [UploadManager] which can upload data stored in [storage].
  UploadManager(this.storage);

  /// Start uploading every 10 minutes.
  void startUpload() {
    uploadTimer = Timer.periodic(const Duration(minutes: 10), (timer) async {
      var dataToUpload = await storage.getJsonToUpload();
      print('Uploading ${dataToUpload.length} json objects...');
    });
  }

  /// Stop uploading.
  void stopUpload() => uploadTimer?.cancel();
}
