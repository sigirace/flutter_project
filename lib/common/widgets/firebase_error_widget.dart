import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
    showFirebaseErrorSnack(
  BuildContext context,
  FirebaseException e,
) {
  final snackBar = SnackBar(
    content: Text(e.message ?? 'Unknown error'),
  );
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
