# DV Health - Fitness App

![Screenshot](assets/running_man1.png)

## Overview
DV Health is a comprehensive fitness app designed to facilitate athletes and fitness enthusiasts in tracking and managing their health and exercise routines. The app's core functionality revolves around device connectivity, athlete management, session tracking, and health data analysis. Coaches can harness the power of DV Health to access athlete data, analyze performance metrics, and provide tailored guidance, ensuring athletes reach their peak performance. Welcome to a smarter way to train, compete, and succeed with DV Health.

## Key Features
- **Device Connectivity**: Seamlessly connect and manage fitness devices.
- **Athlete Management**: Organize and access athlete profiles.
- **Session Tracking**: Monitor and record various exercise sessions.
- **Health Data Analysis**: Gather and analyze heart rate data.

## Technical Details

### Main Components

## Model

### `AthletesModel.dart`
- **Description**: Defines the `Athlete` class, representing athletes with a name and login code.
- **Key Components**:
  - `Athlete` class with properties `name` and `loginCode`.
  - Methods for data validation or modification.

### `DeviceConnectionStatus.dart`
- **Description**: Enumerates the different states of device connection and provides a string representation for each state.
- **Key Components**:
  - `DeviceConnectionStatus` enum with values `NOT_CONNECTED`, `CONNECTING`, and `CONNECTED`.
  - Extension method `statusName` for getting the string representation.

### `HRExerciseModel.dart`
- **Description**: Represents a heart rate (HR) exercise session including properties like name, serial, and current heart rate.
- **Key Components**:
  - `HRExerciseModel` class with methods to update heart rate.

### `HRStorageModel.dart`
- **Description**: Manages storage of HR data in a Sembast database.
- **Key Components**:
  - `HRStorage` class with methods for database initialization, data dumping, and uploading.

## View

### `Athletes_view.dart`
- **Description**: Provides a Flutter widget for displaying a list of athletes.
- **Key Components**:
  - `AthleteListView` class extending `StatelessWidget`.
  - `AthleteTile` class for individual athlete tiles.

### `Device_Scan_View.dart`
- **Description**: Widget for scanning and connecting to devices.
- **Key Components**:
  - `_DeviceScanWidgetState` class for managing the scanning state.
  - UI components for displaying device list and connection status.

### `HR_Storage_view.dart`
- **Description**: Widget for viewing and managing heart rate data storage.
- **Key Components**:
  - `HRStorageView` class for managing HR files and displaying data.

### `HRExercise_view.dart`
- **Description**: Displays exercise options and data.
- **Key Components**:
  - `ExerciseOption` and `ExerciseOptionsPage` classes for managing exercise sessions.
  - `ExerciseCard` class for individual exercise options.

### `Link_view.dart`
- **Description**: Widget for a link page related to heart rate calculations.
- **Key Components**:
  - `LinkPage` class with UI elements for heart rate calculation information.

### `Options_view.dart`
- **Description**: Options page with various action tiles.
- **Key Components**:
  - `OptionsPage` and `OptionTile` classes for displaying options.

### `Pincode_view.dart`
- **Description**: Pin code input page for logging in.
- **Key Components**:
  - `PinCode` class for pin code input and validation.

## ViewModel

### `AthleteViewModel.dart`
- **Description**: Manages the list of athletes and their interactions.
- **Key Components**:
  - `AthleteListViewModel` class with a list of `Athlete` objects.

### `DeviceScanViewModel.dart`
- **Description**: Manages device scanning and connection status.
- **Key Components**:
  - `DeviceScanViewModel` class with methods for starting and stopping scans, connecting and disconnecting devices.

### `HRExerciseViewModel.dart`
- **Description**: Manages data and state for specific devices, focusing on subscribing and handling heart rate.
- **Key Components**:
  - `HRExerciseViewModel` class with methods for subscribing to HR data.

### `HRStorageViewModel.dart`
- **Description**: Manages the retrieval and display of stored HR data.
- **Key Components**:
  - `HRStorageViewModel` class with methods for finding and reading HR data files.

### `OptionsViewModel.dart`
- **Description**: Manages navigation to different pages based on user choices.
- **Key Components**:
  - `OptionsViewModel` class with methods for navigating to record session, HR data, and link pages.

### `PincodeViewModel.dart`
- **Description**: Manages the validation of pin code entries.
- **Key Components**:
  - `PincodeViewModel` class with a method for pin code validation.

### Entry Point
- `main.dart`: The main.dart file serves as the entry point for the app. It defines the main MyApp widget, which initializes the app's theme and starts on the home page.


## Software and Libraries Used

### Flutter 3.13.3
- We used Flutter as the framework for developing the user interface and logic of our application.

### Flutter SDK 2.12.0
- This is the Software Development Kit for Flutter, which provides the necessary tools for Flutter app development.

### Dart 3.1.1
- Dart is the programming language used for building Flutter apps, and we have used version 3.1.1 of Dart.

### Windows 10
- Our development environment was based on Windows 10.

### Android Versions 9 and 10
- These were the target devices for our application, and our implementation was tested on Android 9 and 10.

### Supported Platforms
- Our application is designed to run on Android devices and Windows PCs.

### Movesense Library version 2.0.0
- We incorporated the Movesense library to generate signals and collect data from Movesense sensors.

### Permission Handler Library version 11.1.0
- The Permission Handler library was used to manage permissions required by the application.

### Python
- We also used Python as part of our implementation.

### Python Libraries - numpy and matplotlib
- These Python libraries were employed to visualize the 12-hour data collection process, helping us verify the correctness of data collection.

## Note

Please be aware that our system has not been tested on iOS devices. It is optimized and intended for use on Android and Windows platforms.

Thank you for using our software, and if you have any questions or encounter any issues, feel free to reach out to our support team.



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

