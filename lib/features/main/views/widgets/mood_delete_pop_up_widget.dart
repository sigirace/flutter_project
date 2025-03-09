import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoodDeletePopUpWidget extends StatelessWidget {
  const MoodDeletePopUpWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoActionSheet(
      title: const Text("Delete Note"),
      message: const Text("Are you sure you want to do this?"),
      actions: [
        CupertinoActionSheetAction(
          onPressed: () {},
          isDestructiveAction: true,
          child: const Text("Delete"),
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(
          "Cancel",
          style: TextStyle(
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
