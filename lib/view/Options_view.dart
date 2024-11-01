import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mhealth_app1/view_model/OptionsViewModel.dart';

/// Represents the options page with various action tiles.
class OptionsPage extends StatelessWidget {
  final OptionsViewModel viewModel = OptionsViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF15A196),
        title: Text('''
         Welcome back
    Glad to have you back'''),
      ),
      body: Container(
        color: Color(0xFF15A196),
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              OptionTile(
                icon: FontAwesomeIcons.running,
                text: 'Record Session',
                onTap: () => viewModel.goToRecordSession(context),
              ),
              OptionTile(
                icon: FontAwesomeIcons.heartbeat,
                text: 'HR data',
                onTap: () => viewModel.goToHRData(context),
              ),
              OptionTile(
                icon: FontAwesomeIcons.link,
                text: 'Link',
                onTap: () => viewModel.goToLinkPage(context),
              ),
            ],
            color: Color(0xFFAFDFDB),
          ).toList(),
        ),
      ),
    );
  }
}

/// Represents an option tile on the options page.
class OptionTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const OptionTile({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Color(0xFFAFDFDB), // Foreground color
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(text, style: TextStyle(color: Colors.black87)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.black54),
        onTap: onTap,
      ),
    );
  }
}
