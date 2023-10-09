import 'package:flutter/material.dart';
import 'package:test/presentation/widgets/hamburger_menu.dart';

import 'package:flutter_gen/gen_l10n/app_localization.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.apptitle),
          //const Text("The Recipe Bloc"),
        ),
        drawer: const HamburgerMenu(),
        body: const Center(child: Icon(Icons.book_rounded, color: Colors.grey, size: 250)));
  }
}
