import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Device.dart';
import 'DeviceModel.dart';
import '../view_model/AppModel.dart';
import 'options_page.dart';

class ExerciseOption extends StatefulWidget {
  // tager en Device objekt som en parameter
  final Device device;
  const ExerciseOption(this.device);

  @override
  State<StatefulWidget> createState() {
    return ExerciseOptionsPage();
  }
}

class ExerciseOptionsPage extends State<ExerciseOption> {
  late AppModel _appModel;

  @override
  void initState() {
    // on initialization (iinit), får den instance af appmodel from provvider.of
    super.initState();
    _appModel = Provider.of<AppModel>(context, listen: false);
    _appModel.onDeviceMdsDisconnected(
        (device) => Navigator.pop(context)); // navigator back til current page
  }

  @override
  void dispose() {
    _appModel.disconnectFromDevice(
        widget.device); // disconnector ved at bruge _appModel
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Device device = widget.device;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => OptionsPage())),
        ),
        title: Text('Sessions'),
        backgroundColor: Color(0xFF15A196),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: ListView(
          children: [
            ExerciseCard(
                exerciseName: 'WALK',
                dataFields: ['Step count', 'Total distance'],
                device: device),
            ExerciseCard(
                exerciseName: 'RUN',
                dataFields: ['Total distance', 'Time'],
                device: device),
            ExerciseCard(
                exerciseName: 'BENCH',
                dataFields: ['Total reps', 'Total sets'],
                device: device),
          ],
        ),
      ),
    );
  }
}

class ExerciseCard extends StatefulWidget {
  final String exerciseName;
  final List<String> dataFields;
  final Device device;

  ExerciseCard({
    required this.exerciseName,
    required this.dataFields,
    required this.device,
  });

  @override
  _ExerciseCardState createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  Map<String, TextEditingController> controllers = {};
  bool isWorkoutStarted = false;
  String hrData = "No data"; // Variable to hold HR data

  void startWorkout(DeviceViewModel deviceModel) {
    setState(() {
      isWorkoutStarted = true;
    });
    deviceModel.subscribeToHr();
    // Listen to HR data updates
    deviceModel.addListener(() {
      setState(() {
        hrData = deviceModel.hrData; // Update HR data on UI
      });
    });
  }

  void endWorkout(DeviceViewModel deviceModel) {
    setState(() {
      isWorkoutStarted = false;
      hrData = "No data"; // Reset HR data display
    });
    deviceModel.unsubscribeFromHr();
  }

  @override
  Widget build(BuildContext context) {
    Device device = widget.device;
    return ChangeNotifierProvider(
      create: (context) => DeviceViewModel(device.name, device.serial),
      child: Consumer<DeviceViewModel>(
        builder: (context, deviceModel, child) {
          return Card(
            margin: EdgeInsets.all(8.0),
            color: Color(0xFFAFDFDB), // Card color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.exerciseName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Divider(),
                  for (String field in widget.dataFields) ...[
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: controllers[field],
                            decoration: InputDecoration(
                              labelText: field,
                              fillColor: Colors.white,
                              filled: true,
                              isDense: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                      ],
                    ),
                    SizedBox(height: 8),
                  ],
                  if (isWorkoutStarted) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("HR Data: $hrData"),
                    ),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.play_arrow, color: Colors.white),
                        label: Text('Start Workout'),
                        onPressed: () => startWorkout(deviceModel),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, // background color
                          onPrimary: Colors.white, // foreground color
                        ),
                      ),
                      ElevatedButton.icon(
                        icon: Icon(Icons.stop, color: Colors.white),
                        label: Text('End Workout'),
                        onPressed: () => endWorkout(deviceModel),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red, // background color
                          onPrimary: Colors.white, // foreground color
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
