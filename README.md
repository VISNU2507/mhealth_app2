# DV Health - Fitness App

![Screenshot](lib/assets/running_man1.png)

## Overview
DV Health is a comprehensive fitness app designed to facilitate athletes and fitness enthusiasts in tracking and managing their health and exercise routines. The app's core functionality revolves around device connectivity, athlete management, session tracking, and health data analysis.

## Key Features
- **Device Connectivity**: Seamlessly connect and manage fitness devices.
- **Athlete Management**: Organize and access athlete profiles.
- **Session Tracking**: Monitor and record various exercise sessions.
- **Health Data Analysis**: Gather and analyze heart rate data.

## Technical Details

### Main Components

#### Model
- `Device.dart`: This file defines the Device class, which encapsulates data and the status of a device. It includes methods to handle device connections and disconnections.
- `DeviceConnectionStatus.dart`: This file contains an enumeration DeviceConnectionStatus that represents different device connection states, such as "NOT_CONNECTED," "CONNECTING," and "CONNECTED."

#### View
- `athlete_list_page.dart`: This file defines the AthleteListPage widget, which displays a list of athletes. Each athlete is represented as an AthleteTile, and you can navigate to the login page for each athlete.
- 
- `exercise_options_page.dart`: In this file, you'll find the ExerciseOption widget, which allows users to select exercise options based on the connected device. It also handles the start and end of workouts.
  
- `HR_data_page.dart`: This file defines the HRDataPage widget, which is intended to display heart rate data. However, it appears to be incomplete and doesn't contain specific functionality.
  
- `link_page.dart`: The LinkPage widget is defined in this file. It's a simple page with the title "Link" and a background color.
  
- `login_page.dart`: This file contains the LoginPage widget, which is used for user login. Users enter a PIN code, and if it matches the login code, they are navigated to the options page.
  
- `options_page.dart`: The OptionsPage widget is defined here. It serves as a central hub for navigating to different sections of the app, such as sessions, heart rate data, and links.
- 
- `ScanWidget.dart`: This file defines the ScanWidget widget, which is responsible for scanning and connecting to devices. It lists available devices and allows users to start or stop scanning.

#### View_model
- `AppModel.dart`: The AppModel class manages the app's overall state, including the list of devices, scanning status, and device connections.
  
- `DeviceModel.dart`: The DeviceModel class handles the data and state for individual devices, particularly focusing on subscribing to and handling heart rate data.
  
- `DeviceViewModel.dart`: Similar to DeviceModel, the DeviceViewModel class manages data and state for a specific device, emphasizing heart rate data subscription and handling.

### Entry Point
- `main.dart`: The main.dart file serves as the entry point for the app. It defines the main MyApp widget, which initializes the app's theme and starts on the home page.

## Code Examples

### Important page (exercise:options_page)
```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/Device.dart';
import '../view_model/DeviceViewModel.dart';
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

