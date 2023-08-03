import 'package:flutter/material.dart';

class ProviderContext with ChangeNotifier {
  String _authid = '';
  String _authtoken = '';
  String _typeuser = '';
  String _language = 'az';

  String get authid => _authid;
  String get token => _authtoken;
  String get usertype => _typeuser;
  String get language => _language;

  void changedata(type, value) {
    if (type == 'token') {
      _authtoken = value;
    } else if (type == 'usertype') {
      _typeuser = value;
    } else if (type == 'authid') {
      _authid = value;
    } else if (type == 'language') {
      _language = value;
    }

    notifyListeners();
  }
}
