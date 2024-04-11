import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/presentation/views/spash_screen.dart';

import 'package:test/utils/constants/globals.dart';
import 'package:test/utils/resources/localizator.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _prefLocale = const Locale('NULL');
  Locale get locale => _prefLocale;

  LocaleProvider() {
    _loadPreferredLocale();
    print(printSignifier + "PREF LOCALE: $_prefLocale");
  }

  void _loadPreferredLocale() async {
    print(printSignifier + "Recalling Preferred Locale");
    var prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('AppInfo_DefLocale') ?? 'en';
    // print("BEFORE RECALLING: $_prefLocale");
    // print("Stored Locale: $languageCode");
    _prefLocale = Locale(languageCode);
    // print("AFTER RECALLING: $_prefLocale");

    notifyListeners();
  }

  void setLocale(Locale newlocale) async {
    print(printSignifier + "Setting Preferred Locale " + newlocale.languageCode);

    if (newlocale == locale) {
      //Already Active Locale Safety
      print(printSignifier + "Selected Locale is Already Active");
      return null;
    }
    if (!LocalizationManager.allLang.contains(locale)) {
      //Not-existing Locale Safety
      print(printSignifier + "Selected Locale isn't Found");
      return null;
    }

    var prefs = await SharedPreferences.getInstance();
    bool languageCode = await prefs.setString('AppInfo_DefLocale', newlocale.languageCode);
    // String? Lan = await prefs.getString('AppInfo_DefLocale');
    // print("MSG Locale: $languageCode"); //FIXME - Display a Toastification when language is changed
    // print("Lan Locale: $Lan");

    _prefLocale = newlocale;
    // Navigator.pushAndRemoveUntil(_, MaterialPageRoute(builder: (_) => const SpashScreen()), (route) => false);

    notifyListeners();
    // Restart.restartApp();
  }
}



// void _saveLocale() async {
  // var prefs = await SharedPreferences.getInstance();
  // String languageCode = prefs.setString('AppInfo_DefaultLocale', 'fa');
  // // String countryCode = prefs.getString('countryCode') ?? 'ps';
  // return Locale(languageCode, countryCode);
// }

// Future<Locale> _fetchLocale() async {
//   var prefs = await SharedPreferences.getInstance();
//   String languageCode = prefs.getString('AppInfo_DefaultLocale') ?? 'ar';
//   // String countryCode = prefs.getString('countryCode') ?? 'ps';
//   return Locale(languageCode); //countryCode
// }
