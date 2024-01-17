import 'dart:async';
import 'package:flutter/material.dart';
import '../model/DeviceScanModel.dart';
import '../model/DeviceConnectionStatus.dart';
import '../view_model/DeviceScanViewModel.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'HRExercise_view.dart';

class ScanWidget extends StatefulWidget {
  @override
  _ScanWidgetState createState() => _ScanWidgetState();
}

class _ScanWidgetState extends State<ScanWidget> {
  late DeviceScanViewModel model;
  bool isLoading = false; // New state to track loading for a device

  @override
  void initState() {
    super.initState();
    initPlatformState();
    model = Provider.of<DeviceScanViewModel>(context, listen: false);
    model.onDeviceMdsConnected((device) {
      if (mounted) {
        setState(() {
          isLoading = false; // Stop loading when device is connected
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ExerciseOption(device)));
      }
    });
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;

    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();
    debugPrint("PermissionStatus: $statuses");
  }

  Widget _buildDeviceItem(BuildContext context, int index) {
    return Card(
      child: ListTile(
        title: Text(model.deviceList[index].name ?? 'Unknown Device'),
        subtitle: Text(model.deviceList[index].address ?? 'No Address'),
        trailing: isLoading
            ? CircularProgressIndicator()
            : Text(model.deviceList[index].connectionStatus.statusName),
        onTap: () {
          setState(() {
            isLoading = true; // Start loading when a device is tapped
          });
          model.connectToDevice(model.deviceList[index]);
        },
      ),
    );
  }

  Widget _buildDeviceList(List<DeviceScan> deviceList) {
    //hey
    return Expanded(
      child: ListView.builder(
        itemCount: model.deviceList.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildDeviceItem(context, index),
      ),
    );
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
        backgroundColor: Color(0xFF15A196),
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: Consumer<DeviceScanViewModel>(
          builder: (context, model, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  onPressed: onScanButtonPressed,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: Text(model.scanButtonText),
                ),
                _buildDeviceList(model.deviceList),
              ],
            );
          },
        ),
      ),
    );
  }
}
