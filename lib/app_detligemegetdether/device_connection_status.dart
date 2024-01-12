// device_connection_status.dart
enum DeviceConnectionStatus { NOT_CONNECTED, CONNECTING, CONNECTED }

extension DeviceConnectionStatusExtension on DeviceConnectionStatus {
  String get statusName {
    switch (this) {
      case DeviceConnectionStatus.NOT_CONNECTED:
        return "Not connected";
      case DeviceConnectionStatus.CONNECTING:
        return "Connecting";
      case DeviceConnectionStatus.CONNECTED:
        return "Connected";
      default:
        return "Unknown";
    }
  }
}
