import 'package:flutter/material.dart';

/// This class represents a Flutter widget for a link page.
class LinkPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Heart Rate Calculator'),
        backgroundColor: Color(0xFF15A196),
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            Text(
              'Calculate Your Target Heart Rate',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Resting Heart Rate (RHR): Your resting heart rate is the number of times your heart beats per minute while at complete rest. It’s best measured first thing in the morning before you get out of bed.',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            // Image and other contents go here
            // ...
            Text(
              'Heart Rate Reserve (HRR): HRR is calculated as the difference between your maximum heart rate and your resting heart rate.',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            // Calculator widget or input fields
            // ...
            Text(
              'Target Heart Rate: This is the desired range of heart rate reached during aerobic exercise which enables one’s heart and lungs to receive the most benefit from a workout.',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            SizedBox(height: 20),
            // More content and interactive elements
            // ...
          ],
        ),
      ),
    );
  }
}
