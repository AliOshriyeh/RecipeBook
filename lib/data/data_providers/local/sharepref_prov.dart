// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class ShrPrefProvider {
  Future<SharedPreferences> get activeShrPref async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<List<String>?> getStrList(String inkey) async {
    final SharedPreferences prefs = await activeShrPref;
    var result = prefs.getStringList(inkey);
    return result;
  }

  Future<bool> setStrList(String inkey, List<String> inValue) async {
    final SharedPreferences prefs = await activeShrPref;
    var result = await prefs.setStringList(inkey, inValue);
    return result;
  }
}
