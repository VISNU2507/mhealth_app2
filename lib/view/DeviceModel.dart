import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:mdsflutter/Mds.dart';
// mamager data og state for af specifik device, focusing on subscribing and handling heart rate

class DeviceViewModel extends ChangeNotifier {
  String? _serial;
  String? _name;

  String? get name => _name;
  String? get serial => _serial;

  StreamSubscription? _hrSubscription;
  String _hrData = ""; // store latest heartrate
  String get hrData => _hrData;
  bool get hrSubscribed => _hrSubscription != null; //returner bool

  DeviceViewModel(this._name, this._serial);

  void subscribeToHr() {
    _hrData = "";
    _hrSubscription = MdsAsync.subscribe(
            Mds.createSubscriptionUri(_serial!, "/Meas/HR"), "{}")
        .listen((event) {
      _onNewHrData(event);
    });
    notifyListeners(); //notifier alle listeners
    print(_hrData);
  }

  void _onNewHrData(dynamic hrData) {
    Map<String, dynamic> body = hrData["Body"];
    double hr = body["average"];
    _hrData = hr.toStringAsFixed(1) + " bpm";
    notifyListeners();
    print(_hrData);
  }

  void unsubscribeFromHr() {
    if (_hrSubscription != null) {
      _hrSubscription!.cancel();
    }
    _hrSubscription = null;
    notifyListeners();
  }
}
