import 'package:flutter/material.dart';
import 'package:mhealth_app1/view_model/HRStorageViewModel.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

/// This class represents a widget for viewing and managing heart rate data storage.
class HRStorageView extends StatefulWidget {
  @override
  _HRStorageViewState createState() => _HRStorageViewState();
}

class _HRStorageViewState extends State<HRStorageView> {
  final HRStorageViewModel viewModel = HRStorageViewModel();
  List<Map<String, dynamic>> filesData = [];
  dynamic selectedFileData;
  bool showData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HR Data'),
        backgroundColor: Color(0xFF15A196),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () async {
              var data = await viewModel.findFiles();
              setState(() {
                filesData = data;
              });
            },
            child: Text('Load HR Files'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filesData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${filesData[index]['name']}'),
                  subtitle: Text('${filesData[index]['datetime']}'),
                  onTap: () async {
                    final directory = await getApplicationDocumentsDirectory();
                    final filePath =
                        join(directory.path, filesData[index]['name']);
                    var data = await viewModel.readJsonFile(filePath);
                    setState(() {
                      selectedFileData = data;
                      showData =
                          true; // Set to true to show the data on the screen
                    });
                  },
                );
              },
            ),
          ),
          if (showData) ...[
            Expanded(
              child: SingleChildScrollView(
                child: Text(selectedFileData.toString()),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showData = false; // Set to false to hide the data
                });
              },
              child: Text('Hide Data'),
            ),
          ],
        ],
      ),
    );
  }
}
