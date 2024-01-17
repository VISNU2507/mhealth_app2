import 'package:flutter/material.dart';
import 'package:mhealth_app1/model/AthletesModel.dart';

class AthleteListViewModel {
  List<Athlete> athletes = [
    Athlete(name: 'Athlete 1', loginCode: '1234'),
    Athlete(name: 'Athlete 2', loginCode: '4321'),
    Athlete(name: 'Athlete 3', loginCode: '1234'),
    Athlete(name: 'Athlete 4', loginCode: '4321'),
    Athlete(name: 'Athlete 5', loginCode: '1234'),
    Athlete(name: 'Athlete 6', loginCode: '4321'),
    // Add more athletes as needed
  ];

  // Add logic for manipulating athletes, such as adding, removing, or sorting athletes
}
