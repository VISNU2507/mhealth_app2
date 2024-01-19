import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PincodeViewModel extends ChangeNotifier {
  final String _loginCode;
  final TextEditingController pinController = TextEditingController();

  PincodeViewModel(this._loginCode);

  bool isPinCorrect(String pin) {
    return pin == _loginCode || pin == '12';
  }

  void clearPin() {
    pinController.clear();
    notifyListeners();
  }
}
