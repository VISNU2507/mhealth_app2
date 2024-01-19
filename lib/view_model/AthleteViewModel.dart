import 'package:flutter/material.dart';
import 'package:mhealth_app1/model/AthletesModel.dart';

class AthleteListViewModel extends ChangeNotifier {
  List<Athlete> _athletes = [
    Athlete(name: 'Athlete 1', loginCode: '1234'),
    Athlete(name: 'Athlete 2', loginCode: '4321'),
    Athlete(name: 'Athlete 3', loginCode: '1234'),
    Athlete(name: 'Athlete 4', loginCode: '4321'),
    Athlete(name: 'Athlete 5', loginCode: '1234'),
    Athlete(name: 'Athlete 6', loginCode: '4321'),
  ];

  List<Athlete> get athletes => _athletes;

  // Example: Add an athlete
  void addAthlete(Athlete athlete) {
    _athletes.add(athlete);
    notifyListeners(); // Notify listeners about the change
  }

  // Example: Remove an athlete
  void removeAthlete(Athlete athlete) {
    _athletes.removeWhere((a) => a.loginCode == athlete.loginCode);
    notifyListeners(); // Notify listeners about the change
  }

  // You can add more methods here to manipulate the athletes list
}
