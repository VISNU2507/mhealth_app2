import 'dart:async';
import 'dart:collection';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../model/DeviceScanModel.dart';
import 'package:mdsflutter/Mds.dart';
import '../model/DeviceConnectionStatus.dart';

class DeviceScanViewModel extends ChangeNotifier {
  final Set<DeviceScan> _deviceList = Set();
  bool _isScanning = false;
  void Function(DeviceScan)? _onDeviceMdsConnectedCb;
  void Function(DeviceScan)? _onDeviceDisonnectedCb;

  UnmodifiableListView<DeviceScan> get deviceList =>
      UnmodifiableListView(_deviceList);

  bool get isScanning => _isScanning;

  String get scanButtonText => _isScanning ? "Stop scan" : "Start scan";

  void onDeviceMdsConnected(void Function(DeviceScan) cb) {
    _onDeviceMdsConnectedCb = cb;
  }

  void onDeviceMdsDisconnected(void Function(DeviceScan) cb) {
    _onDeviceDisonnectedCb = cb;
  }

  void startScan() {
    _deviceList.forEach((device) {
      if (device.connectionStatus == DeviceConnectionStatus.CONNECTED) {
        disconnectFromDevice(device);
      }
    });

    _deviceList.clear();
    notifyListeners();

    try {
      Mds.startScan((name, address) {
        DeviceScan device = DeviceScan(name, address);
        if (!_deviceList.contains(device)) {
          _deviceList.add(device);
          notifyListeners();
        }
      });
      _isScanning = true;
      notifyListeners();
    } on PlatformException {
      _isScanning = false;
      notifyListeners();
    }
  }

  void stopScan() {
    Mds.stopScan();
    _isScanning = false;
    notifyListeners();
  }

  void connectToDevice(DeviceScan device) {
    device.onConnecting();
    Mds.connect(
        device.address!,
        (serial) => _onDeviceMdsConnected(device.address, serial),
        () => _onDeviceDisconnected(device.address),
        () => _onDeviceConnectError(device.address));
  }

  void disconnectFromDevice(DeviceScan device) {
    Mds.disconnect(device.address!);
    _onDeviceDisconnected(device.address);
  }

  void _onDeviceMdsConnected(String? address, String serial) {
    DeviceScan foundDevice =
        _deviceList.firstWhere((element) => element.address == address);

    foundDevice.onMdsConnected(serial);
    notifyListeners();
    if (_onDeviceMdsConnectedCb != null) {
      _onDeviceMdsConnectedCb!.call(foundDevice);
    }
  }

  void _onDeviceDisconnected(String? address) {
    DeviceScan foundDevice =
        _deviceList.firstWhere((element) => element.address == address);
    foundDevice.onDisconnected();
    notifyListeners();
    if (_onDeviceDisonnectedCb != null) {
      _onDeviceDisonnectedCb!.call(foundDevice);
    }
  }

  void _onDeviceConnectError(String? address) {
    _onDeviceDisconnected(address);
  }
}
