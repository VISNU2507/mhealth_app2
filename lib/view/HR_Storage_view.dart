import 'package:flutter/material.dart';
import 'package:mhealth_app1/view_model/HRStorageViewModel.dart';

class HRStorageView extends StatelessWidget {
  final HRStorageViewModel viewModel = HRStorageViewModel();

  HRStorageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HR Data'),
        backgroundColor: Color(0xFF15A196),
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: Center(
          child: ElevatedButton(
            onPressed: () async {
              await displayJsonData();
            },
            child: Text('Display HR Data'),
          ),
        ),
      ),
    );
  }

  Future<void> displayJsonData() async {
    final data = await viewModel.findFiles();
  }
}
