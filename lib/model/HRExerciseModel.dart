// This file will contain the data representation of an HR Exercise.

class HRExerciseModel {
  final String name;
  final String serial;
  // Add other exercise related properties here, like heart rate data

  HRExerciseModel({required this.name, required this.serial});

// Example property: current heart rate
  int currentHeartRate = 0;

// You can add other methods and properties related to the exercise data here
// For example, a method to update the current heart rate:
  void updateHeartRate(int newHeartRate) {
    currentHeartRate = newHeartRate;
// Add any additional logic if necessary
  }
}
