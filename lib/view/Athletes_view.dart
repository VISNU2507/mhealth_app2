/// This class represents a Flutter widget for displaying a list of athletes.
/// It extends StatelessWidget and is used to build the athlete list view.
import 'package:flutter/material.dart';
import 'package:mhealth_app1/view_model/AthleteViewModel.dart';
import 'Pincode_view.dart';

class AthleteListView extends StatelessWidget {
  final AthleteListViewModel viewModel = AthleteListViewModel();

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
        child: ListView.builder(
          itemCount: viewModel.athletes.length,
          itemBuilder: (context, index) {
            final athlete = viewModel.athletes[index];
            return AthleteTile(
                athleteName: athlete.name, loginCode: athlete.loginCode);
          },
        ),
      ),
    );
  }
}

/// Represents an individual athlete tile in the athlete list view.
class AthleteTile extends StatelessWidget {
  /// The name of the athlete.
  final String athleteName;

  /// The login code associated with the athlete.
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
                  builder: (context) => PinCode(loginCode: loginCode)),
            );
          },
        ),
      ),
    );
  }
}
