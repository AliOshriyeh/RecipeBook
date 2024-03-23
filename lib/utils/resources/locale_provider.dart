import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/utils/constants/globals.dart';
import 'package:test/utils/resources/localizator.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;
  // {
  //   resetLocale();
  //   return _locale ?? const Locale('fr');
  // }

  void setLocale(Locale locale) {
    if (LocalizationManager.allLang.contains(locale)) return; //Not-existing Locale Safety

    // var prefs = await SharedPreferences.getInstance();
    // bool languageCode = await prefs.setString('AppInfo_DefLocale', locale.languageCode);
    // print("MSG Locale: $languageCode");

    _locale = locale;
    notifyListeners();
  }

  void resetLocale() async {
    print(printSignifier + "Recalling Locale");
    var prefs = await SharedPreferences.getInstance();
    String languageCode = prefs.getString('AppInfo_DefLocale') ?? 'en';
    // print("MSG Locale: $languageCode");

    _locale = Locale(languageCode);
    notifyListeners();
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
