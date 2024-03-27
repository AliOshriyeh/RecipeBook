import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as prv;
import 'package:test/utils/resources/locale_provider.dart';
import 'package:test/utils/resources/localizator.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final provider = prv.Provider.of<LocaleProvider>(context, listen: false);
    // final locale = provider.locale;

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.settings)),
      body: Column(children: [
        ListTile(
            title: const Text("Language"),
            subtitle: DropdownButton(
              hint: const Text("Choose a Language"),
              // value: locale,
              icon: Container(width: 12),
              items: LocalizationManager.allLang.map((thisLocale) {
                return DropdownMenuItem(
                  value: thisLocale,
                  child: Center(
                    child: Text(thisLocale.languageCode, style: const TextStyle(fontSize: 32)),
                  ),
                  onTap: () {
                    final provider = prv.Provider.of<LocaleProvider>(context, listen: false);
                    provider.setLocale(thisLocale);
                  },
                );
              }).toList(),
              onChanged: (_) {},
            )),
      ]),

      // const SpinkitCustomLoading(typeNum: 3),
    );
  }
}
