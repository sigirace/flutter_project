import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/setting/view_models/mode_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeWidget extends ConsumerWidget {
  const DarkModeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: const Text('Dark Mode'),
      trailing: CupertinoSwitch(
        value: ref.watch(modeViewModelProvider).isDarkMode,
        onChanged: (value) =>
            ref.read(modeViewModelProvider.notifier).setDarkMode(value),
      ),
    );
  }
}
