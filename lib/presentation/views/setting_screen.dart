import 'package:flutter/material.dart';
import 'package:test/presentation/widgets/spinkit_loading.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: const SpinkitCustomLoading(typeNum: 3),
    );
  }
}
