/// Device Connection Status Enumeration
///
/// Enumerates the different states of device connection:
/// NOT_CONNECTED, CONNECTING, and CONNECTED.
enum DeviceConnectionStatus {
  NOT_CONNECTED,
  CONNECTING,
  CONNECTED
} //presents forsklelige stdaier connection status

/// Extension on DeviceConnectionStatus
///
/// Adds a method to get a string representation of the connection status.
extension DeviceConnectionStatusExtenstion on DeviceConnectionStatus {
  String get statusName {
    switch (this) {
      case DeviceConnectionStatus.NOT_CONNECTED:
        return "Not connected";
      case DeviceConnectionStatus.CONNECTING:
        return "Connecting";
      case DeviceConnectionStatus.CONNECTED:
        return "MDS connected";
    }
  }
}
