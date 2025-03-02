import 'package:flutter/material.dart';
import 'package:flutter_project/features/setting/views/setting_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class FeatureScreen extends StatelessWidget {
  static const String path = '/';
  static const String name = 'feature';

  const FeatureScreen({super.key});

  void _onPressed(BuildContext context) {
    context.push(SettingView.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feature Screen'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _onPressed(context),
            icon: const FaIcon(FontAwesomeIcons.gear),
          ),
        ],
      ),
      body: const Center(
        child: Text('Feature Screen'),
      ),
    );
  }
}
