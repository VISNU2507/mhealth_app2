import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../view/HR_Storage_view.dart';
import '../view/Link_view.dart';
import '../view/Device_Scan_view.dart';
import 'HRExerciseViewModel.dart';
import '../view_model/DeviceScanViewModel.dart';

class OptionsViewModel {
  void goToRecordSession(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
                create: (context) => DeviceScanViewModel(),
                child: MaterialApp(
                  home: DeviceScanWidget(),
                ),
              )),
    );
  }

  void goToHRData(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (_) => HRExerciseViewModel('Name of Device',
              'Serial Number'), // Provide actual values for _name and _serial here
          child: HRStorageView(),
        ),
      ),
    );
  }

  void goToLinkPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LinkPage()),
    );
  }
}
