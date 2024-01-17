import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mdsflutter/Mds.dart';
import 'package:mhealth_app1/model/HRstorage.dart';
// manager data og state for af specifik device, focusing on subscribing and handling heart rate

class HRViewModel extends ChangeNotifier {
  String? _serial;
  String? _name;

  String? get name => _name;
  String? get serial => _serial;
  late Storage storage;

  HRViewModel(this._name, this._serial) {
    storage = Storage(this);
    storage.init();
  }

  StreamSubscription? _hrSubscription;
  String _hrData = ""; // store latest heartrate
  String get hrData => _hrData;
  bool get hrSubscribed => _hrSubscription != null; //returner bool

  final _hrcontroller = StreamController<int>.broadcast();

  Stream<int> get hbeat => _hrcontroller.stream;

  void _onNewHrData(dynamic hrData) {
    Map<String, dynamic> body = hrData["Body"];
    double hr = body["average"];
    _hrcontroller.add(hr.toInt());
    _hrData = hr.toStringAsFixed(1) + " bpm";
    notifyListeners();
    print(_hrData);
  }

  void subscribeToHr() {
    _hrData = "";
    _hrSubscription = MdsAsync.subscribe(
            Mds.createSubscriptionUri(_serial!, "/Meas/HR"), "{}")
        .listen((event) {
      _onNewHrData(event);
    });
    notifyListeners(); //notifier alle listeners
    //  print(_hrData);
  }

  void unsubscribeFromHr() {
    if (_hrSubscription != null) {
      _hrSubscription!.cancel();
    }
    _hrSubscription = null;
    notifyListeners();
  }
}
