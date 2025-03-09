import 'package:flutter/material.dart';
import 'package:flutter_project/features/setting/views/widgets/dark_mode_widget.dart';
import 'package:flutter_project/features/setting/views/widgets/log_out_widget.dart';

class SettingView extends StatelessWidget {
  static const String routePath = '/setting';
  static const String routeName = 'setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: const [
          DarkModeWidget(),
          LogOutWidget(),
        ],
      ),
    );
  }
}
