import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/authentications/view_models/log_in_view_model.dart';
import 'package:flutter_project/authentications/views/login_screen.dart';
import 'package:flutter_project/constants/fontsize.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LogOutWidget extends ConsumerWidget {
  const LogOutWidget({super.key});

  void signOut(BuildContext context, WidgetRef ref) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text("Are you sure?"),
        content: const Text("If you log out, click yes."),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "No",
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              ref.read(loginProvider.notifier).signOut();
              context.go(LoginScreen.routePath);
            },
            isDestructiveAction: true,
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(
        'Log out',
        style: TextStyle(
          fontSize: FontSize.fs14,
          fontWeight: FontWeight.w500,
          color: Colors.red,
        ),
      ),
      onTap: () => signOut(context, ref),
    );
  }
}
