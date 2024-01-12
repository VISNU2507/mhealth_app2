import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App UI',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HealthAppPage(),
    );
  }
}

class HealthAppPage extends StatelessWidget {
  const HealthAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the background color
    final Color backgroundColor = Color(0xFF15A196);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Health app', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              // Handle All records action
            },
          ),
        ],
      ),
      body: Container(
        color: backgroundColor, // Use the background color here
        child: ListView(
          children: const <Widget>[
            UserCard(
              title: 'Athlete 1',
              subtitle: '',
              recordsCount: 4,
              iconData: Icons.sports_kabaddi, // Use an appropriate icon
            ),
            UserCard(
              title: 'Athlete 2',
              subtitle: '',
              recordsCount: 2,
              iconData: Icons.run_circle, // Use an appropriate icon
            ),
            UserCard(
              title: 'Athlete 3',
              subtitle: '',
              recordsCount: 3,
              iconData: Icons.run_circle, // Use an appropriate icon
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final int recordsCount;
  final IconData iconData;

  const UserCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.recordsCount,
    required this.iconData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the card color
    final Color cardColor = Color(0xFF9AFFF7);

    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: cardColor, // Card color
        borderRadius:
            BorderRadius.circular(10), // Adjust the border radius as needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(iconData, color: Colors.black54),
        title: Text(title, style: TextStyle(color: Colors.black87)),
        subtitle: Text('$recordsCount records found',
            style: TextStyle(color: Colors.black54)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}

//hey