import 'dart:async';
import 'package:flutter/material.dart';
import '../model/Device.dart';
import '../model/DeviceConnectionStatus.dart';
import '../view_model/AppModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'exercise_options_page.dart';

class ScanWidget extends StatefulWidget {
  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  late AppModel model;

  @override
  void initState() {
    // initialiserer platform state dernede
    super.initState();
    initPlatformState();
    model = Provider.of<AppModel>(context, listen: false);
    model.onDeviceMdsConnected((device) => Navigator.push(context,
        MaterialPageRoute(builder: (context) => ExerciseOption(device))));
  }

  Future<void> initPlatformState() async {
    // asynkront spørger om permissions for bluetooth funktionalitet, husk android indstillinger ændring skal laves.
    if (!mounted) return;

    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
    debugPrint("PermissionStatus: $statuses");
  }

  Widget _buildDeviceItem(BuildContext context, int index) {
    // en ui card for devices
    return Card(
      child: ListTile(
        title: Text(model.deviceList[index].name!),
        subtitle: Text(model.deviceList[index].address!),
        trailing: Text(model.deviceList[index].connectionStatus.statusName),
        onTap: () => model.connectToDevice(model.deviceList[index]),
      ),
    );
  }

  Widget _buildDeviceList(List<Device> deviceList) {
    return new Expanded(
        child: new ListView.builder(
            itemCount: model.deviceList.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildDeviceItem(context, index)));
  }

  void onScanButtonPressed() {
    if (model.isScanning) {
      model.stopScan();
    } else {
      model.startScan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scanning devices'),
        backgroundColor: Color(0xFF15A196), // color AppBar
      ),
      body: Container(
        color: Color(0xFF15A196), //  color the bodyen
        child: Consumer<AppModel>(
          builder: (context, model, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: onScanButtonPressed,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white, // Button background color
                    onPrimary: Colors.black, // Butto text color
                  ),
                  child: Text(model.scanButtonText),
                ),
                _buildDeviceList(model.deviceList)
              ],
            );
          },
        ),
      ),
    );
  }
}
