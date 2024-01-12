import 'DeviceConnectionStatus.dart';

// indkapsler data og status af en device dejdnejde
class Device {
  // store device adress, name og serial
  String? _address;
  String? _name;
  String? _serial;
  DeviceConnectionStatus _connectionStatus =
      DeviceConnectionStatus.NOT_CONNECTED;

  Device(String? name, String? address) {
    // constructor der initalize det  dér ovenover
    _name = name;
    _address = address;
  }

  String? get name =>
      _name != null ? _name : ""; // hvis getters er null, return string
  String? get address => _address != null ? _address : "";
  String? get serial => _serial != null ? _serial : "";
  DeviceConnectionStatus get connectionStatus => _connectionStatus;

  void onConnecting() => _connectionStatus = DeviceConnectionStatus.CONNECTING;
  void onMdsConnected(String serial) {
    _serial = serial;
    _connectionStatus = DeviceConnectionStatus.CONNECTED;
  } // setter conection status to "DeviceConnectionStatus.CONNECTED", indicated device connecting

  void onDisconnected() =>
      _connectionStatus = DeviceConnectionStatus.NOT_CONNECTED;

  bool operator ==(o) => //comparer devices
      o is Device && o._address == _address && o._name == _name;
  int get hashCode => _address.hashCode * _name.hashCode;
} // retunrer hash code for device
