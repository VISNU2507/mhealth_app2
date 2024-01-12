import 'package:flutter/material.dart';
import 'login_page.dart';

class AthleteListPage extends StatelessWidget {
  const AthleteListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15A196),
        title: Text('Health app'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: ListView(
          children: <Widget>[
            AthleteTile(athleteName: 'Athlete 1', loginCode: '1234'),
            AthleteTile(athleteName: 'Athlete 2', loginCode: '4321'),
          ],
        ),
      ),
    );
  }
}

class AthleteTile extends StatelessWidget {
  final String athleteName;
  final String loginCode;

  AthleteTile({required this.athleteName, required this.loginCode});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ListTile(
        leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
        title: Text(athleteName, style: TextStyle(color: Colors.black87)),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginPage(loginCode: loginCode)),
            );
          },
        ),
      ),
    );
  }
}
