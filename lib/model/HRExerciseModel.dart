/// HR Exercise Model
///
/// This model represents a heart rate (HR) exercise session.
/// It includes properties like name, serial, and current heart rate.
class HRExerciseModel {
  final String name;
  final String serial;
  final String athleteId; // Add this line
  int currentHeartRate = 0;

  HRExerciseModel({
    required this.name,
    required this.serial,
    required this.athleteId, // Add this parameter
  });

// Example property: current heart rate

  /// Updates the current heart rate with a new value.
  void updateHeartRate(int newHeartRate) {
    currentHeartRate = newHeartRate;
// Add any additional logic if necessary
  }
}
