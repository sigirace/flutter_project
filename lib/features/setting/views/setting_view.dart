import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  static const String path = '/setting';
  static const String name = 'setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
      ),
      body: const Center(
        child: Text('Setting View'),
      ),
    );
  }
}
