import 'package:flutter/material.dart';
import 'Options_view.dart';
import '../view_model/PincodeViewModel.dart';

/// Represents a pin code input page for logging in.
class PinCode extends StatelessWidget {
  final PincodeViewModel viewModel;

  PinCode({super.key, required String loginCode})
      : viewModel = PincodeViewModel(loginCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF15A196),
        title: const Text('Log In'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: const Color(0xFF15A196),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: viewModel.pinController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Pin code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              obscureText: true,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFFAFDFDB),
              ),
              onPressed: () {
// Utilize the ViewModel to check the pin
                if (viewModel.isPinCorrect(viewModel.pinController.text)) {
// Navigate to the options page if the pin is correct
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OptionsPage()),
                  );
                } else {
// Show an error if the pin is incorrect
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incorrect pin code entered',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
              child: const Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}
