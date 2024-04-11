import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class AlignLocaleBase extends StatelessWidget {
  final Widget chicho;
  final BuildContext context;
  AlignLocaleBase({super.key, required this.context, required this.chicho});

  @override
  Widget build(BuildContext context) {
    String direction = AppLocalizations.of(context)!.language;
    Widget RTLWidget = Align(alignment: Alignment.centerRight, child: chicho);
    Widget LTRWidget = Align(alignment: Alignment.centerLeft, child: chicho);
    switch (direction) {
      case "عربي":
        return RTLWidget;
      case "English":
        return LTRWidget;
      case "فارسی":
        return RTLWidget;
      case "Français":
        return LTRWidget;
      default:
        return Align(alignment: Alignment.center, child: chicho);
    }
  }
}
